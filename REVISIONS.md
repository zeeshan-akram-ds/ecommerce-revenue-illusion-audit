# Revisions

## v1.1 (October 2026)

The report and README were stress-tested against their own numbers. Several claims in v1.0 went further than the data supports. v1.0 is preserved at the `v1.0` git tag.

**Recommendation changed**
- "Cut the 28 zombie SKUs now" is now "sort them by cause before cutting any". The data shows the 28 are weak, not why they are weak, and in aggregate they contribute about $67K of profit (1.8%), so they are not loss-makers.

**Corrections**
- The title and cover said 28 products were "bleeding $643K". The $643K figure is the stress scenario for the core 8 products (a 20% margin shock), not a loss from the 28.
- The stress-test text said "one of those 8 products". The scenario applies to all 8.
- "Zero correlation" between discount depth and margin is now "no statistically significant relationship (p = 0.73)", and "no pricing lever waiting to be pulled" was dropped.

**Removed (not supported by the dataset)**
- "Frees up a quarter of operational bandwidth": the dataset has no handling, storage or support cost data.
- "Winning on subsidy" for the top sellers.
- The January 2018 "collapse" interpretation, pending a check that the final month of data is complete.

**Added**
- Evidence labels (Observed, Modeled, Hypothesis) on every finding in the report.
- Definitions, scenario assumptions and limits.
- A note that First Class lateness (100%, 1.00 day average) looks like a fixed promise gap, marked as a hypothesis.
- A five-check self-diagnostic for founders.

**Removed**
- `reports/profit_leak_diagnostic.md`, a duplicate of the v1.0 report text. It remains in git history and at the `v1.0` tag.
