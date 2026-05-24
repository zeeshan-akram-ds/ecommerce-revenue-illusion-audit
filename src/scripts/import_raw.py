import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy import text
import logging
import time
import sys
from dotenv import load_dotenv
import os
from pathlib import Path
load_dotenv(Path(__file__).resolve().parents[1] / "config" / ".env")


# Configure logging for import validation
logging.basicConfig(
    level=logging.INFO, 
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[logging.StreamHandler(sys.stdout)]
)

# Configuration
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
CSV_PATH = os.getenv("CSV_PATH")

def import_raw_data():
    engine = create_engine(f'postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}')
    
    logging.info(f"Initiating import from {CSV_PATH}")
    
    # Validate encoding & load
    try:
        # DataCo dataset typically requires latin1 due to special characters in product names
        df = pd.read_csv(CSV_PATH, encoding='latin1')
    except FileNotFoundError:
        logging.error(f"Fatal: CSV file not found at {CSV_PATH}")
        return
    except Exception as e:
        logging.error(f"Fatal: Pandas read error: {e}")
        return

    # Verify row counts
    initial_row_count = len(df)
    logging.info(f"Source row count established: {initial_row_count} rows.")

    # Standardize columns to match 01_raw_table_ddl.sql precisely
    df.columns = (
        df.columns.str.strip()
        .str.replace(' ', '_')
        .str.replace('(', '')
        .str.replace(')', '')
        .str.lower()
    )

    # Handle timestamp parsing to preserve import stability
    # Storing as string in raw to prevent timezone/parsing rejections mid-import
    if 'order_date' in df.columns:
        df['order_date'] = df['order_date'].astype(str)
    if 'shipping_date' in df.columns:
        df['shipping_date'] = df['shipping_date'].astype(str)

    logging.info("Pushing to PostgreSQL schema 'raw'...")
    start_time = time.time()

    df.columns = (
    df.columns.str.strip()
    .str.replace(' ', '_')
    .str.replace('(', '')
    .str.replace(')', '')
    .str.lower()
    .str.replace(r'_m\d+', '', regex=True)  # strip _m9999 and similar suffixes to avoid import errors
        )
    
    df.rename(columns={
        'order_date_dateorders': 'order_date',
        'shipping_date_dateorders': 'shipping_date'
    }, inplace=True)

    print(df.columns.tolist())
    # Push to SQL & log failures
    try:
        df.to_sql(
            name='dataco_orders', 
            schema='raw', 
            con=engine, 
            if_exists='replace', 
            index=False,
            chunksize=10000,
            method='multi'
        )
        elapsed = round(time.time() - start_time, 2)
        logging.info(f"Database insertion complete in {elapsed} seconds.")
        
        # Post-import reconciliation check
        with engine.connect() as conn:
            result = conn.execute(text("SELECT COUNT(*) FROM raw.dataco_orders"))
            db_row_count = result.scalar()
        
        logging.info("--- RECONCILIATION SUMMARY ---")
        logging.info(f"CSV Source Rows : {initial_row_count}")
        logging.info(f"DB Inserted Rows: {db_row_count}")
        
        if initial_row_count == db_row_count:
            logging.info("STATUS: SUCCESS - Transactional fidelity preserved.")
        else:
            logging.warning("STATUS: FAILED - Row count mismatch detected. Drop raw table and investigate.")

    except Exception as e:
        logging.error(f"Database import failed during execution: {e}")

if __name__ == '__main__':
    import_raw_data()