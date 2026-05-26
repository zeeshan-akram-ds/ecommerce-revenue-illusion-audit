# Key Findings

## SQL Layer Findings

**F-001 - Universal Loss Exposure**  
Every single product in the catalog (118 of 118) has recorded at least one loss-making order. No SKU is operationally clean. The business has no protected profit core.

**F-002 - Expedited Shipping Structural Failure**  
The supply chain is fundamentally incapable of supporting premium SLAs. "First Class" shipping has a 100% late delivery risk rate, averaging a full day behind schedule. Conversely, the cheapest tier ("Standard Class") is the most reliable, arriving slightly ahead of schedule with a 39.7% risk rate. Every premium shipping order likely generates negative customer sentiment.

**F-003 - Top-Line Growth is Bought, Not Earned**  
The top four revenue-generating products are genuinely the most profitable in absolute terms (zero rank divergence), but their commercial scale is heavily subsidized. Approximately 94.4% of their transactions require a discount to convert, and 18.5% of their orders result in a net financial loss.

**F-004 - Extreme Volume Concentration**  
Transaction volume is severely consolidated, making catalog-wide performance metrics misleading. Just 9 products (7.6% of the catalog) generate at least 10,000 orders each, accounting for the vast majority of the 180,519 total transactions. Meanwhile, 39% of the catalog (46 products) generated fewer than 100 orders over a three-year span.