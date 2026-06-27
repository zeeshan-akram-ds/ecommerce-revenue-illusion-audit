"""
Generate a small, representative, PII-safe sample from the raw DataCo
Supply Chain dataset for the public data/sample/ folder.

Usage:
    python src/scripts/generate_data_sample.py

Reads:
    data/raw/DataCoSupplyChainDataset.csv

Writes:
    data/sample/dataco_supply_chain_sample.csv
"""

import pandas as pd

RAW_PATH = "data/raw/DataCoSupplyChainDataset.csv"
OUTPUT_PATH = "data/sample/dataco_supply_chain_sample.csv"

# Total rows to keep in the public sample
SAMPLE_SIZE = 500

# Column to stratify on so rare categories/products still show up in the sample
STRATIFY_COLUMN = "Category Name"

# Columns to drop entirely before anything is written to the public sample.
# These are present in the raw DataCo dataset and look like PII even though
# they're synthetic, better to not ship them at all in a public repo.
COLUMNS_TO_DROP = [
    "Customer Email",
    "Customer Password",
    "Customer Fname",
    "Customer Lname",
    "Customer Street",
    "Customer Zipcode",
    "Product Image",
]


def main():
    df = pd.read_csv(RAW_PATH, encoding="latin-1")

    # Drop PII-looking columns if present
    cols_to_drop = [c for c in df.columns if c in COLUMNS_TO_DROP]
    df = df.drop(columns=cols_to_drop)
    print(f"Dropped columns: {cols_to_drop}")

    # Stratified sample: proportional rows per category, capped at SAMPLE_SIZE total
    if STRATIFY_COLUMN in df.columns:
        frac = SAMPLE_SIZE / len(df)
        sample = (
            df.groupby(STRATIFY_COLUMN, group_keys=False)
            .apply(lambda x: x.sample(frac=frac, random_state=42))
        )
        sample = sample.sample(n=min(SAMPLE_SIZE, len(sample)), random_state=42)
    else:
        sample = df.sample(n=SAMPLE_SIZE, random_state=42)

    sample.to_csv(OUTPUT_PATH, index=False)
    print(f"Wrote {len(sample)} rows to {OUTPUT_PATH}")
    print(f"Columns in sample: {list(sample.columns)}")


if __name__ == "__main__":
    main()
