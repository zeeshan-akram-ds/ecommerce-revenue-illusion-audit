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

**F-005 - Lifecycle Net-Negative Products**
SOLE E35 Elliptical (−$965) and SOLE E25 Elliptical (−$169) are net-negative in absolute profit across their entire three-year transaction history.
The business loses money on these SKUs in aggregate, not just on isolated orders.
The most margin-efficient products (Polar FT4 at 19.86%, Bowflex SelectTech 1090 at 19.85%) lack sufficient volume to offset this drag.

**F-006 - Revenue Trap Products Identified**
SOLE E35 Elliptical ranks 36th in revenue and dead last (118th) in profit at −3.2% net margin.
GoPro HERO3+ and Garmin Forerunner 910XT sit in the bottom 10% of profit despite mid-catalog revenue positions.
10 products identified as confirmed Revenue Traps, commercially visible, operationally destructive.

**F-007 - Discounting Is a Structural Cost, Not a Tactic**
93–97% of orders across virtually all 118 products require a discount to convert.
Discounting is not a promotional lever, it is the default operating model.
No meaningful non-discounted control group exists, making discount elasticity analysis impossible from this dataset alone.

**F-008 - Five Compounded Risk Products Identified**
Five products fail simultaneously on all three operational dimensions: late delivery risk >60%, discount dependency >94%, and net margin <10%.
Includes recognized brands: Under Armour (x2) and ENO Atlas.
These are not isolated underperformers, they represent the worst-case convergence of fulfillment failure, promotional dependency, and margin destruction in a single SKU.