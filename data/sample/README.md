# Sample Data

`dataco_supply_chain_sample.csv` is a 500-row stratified sample drawn from the raw DataCo Supply Chain dataset, for schema reference only.

- Sampled proportionally across `Category Name` so rare categories are still represented.
- PII-looking columns (customer email, password, name, street, zipcode, product image) are removed, they exist in the raw dataset but were never used in this audit.
- This is **not** the full dataset. The full DataCo Supply Chain dataset (180,519 rows, 53 columns) is not included in this repo due to size and licensing; see `docs/data_dictionary.md` for the full schema.

Generated via `src/scripts/generate_data_sample.py`.