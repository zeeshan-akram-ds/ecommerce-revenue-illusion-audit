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

**F-009 - Revenue Traps Are Also the Most Unpredictable**
SOLE E25 (0.81), GoPro HERO3+ (0.74), and SOLE E35 (0.71) are simultaneously the worst margin performers and the most volatile SKUs.
These products do not just lose money, their losses are erratic and unforecastable.
High-revenue products stabilize near 0.46 volatility but are permanently locked into ~11% margin and 94% discount dependency.

**F-010 - Operational Failures Are Chronic, Not Cyclical**
Revenue and profit were flatlined across nearly three years with no growth trajectory.
Late delivery risk and margin volatility remained consistently erratic from month one to the final month, no operational improvement over 36 months.
The sharp drop at the dataset's end indicates a demand collapse or supply chain break, not a temporary fluctuation.
The discount dependency and delivery failures are structural realities, not isolated incidents.

**F-011 - Scale Has Been Deployed Into Mediocrity**
The highest-revenue products cluster directly around the median crosshairs, neither margin leaders nor delivery risk outliers.
The business has not scaled its best performers. It has scaled its most average ones.
28 products sit in the Cut Candidates quadrant, combining below-median margins with above-median delivery failure.

**F-012 - 28 Zombie SKUs Consuming Bandwidth for 2.2% of Revenue**
The Cut Candidates quadrant contains 28 products generating only $763K of $35.2M total revenue, 2.2% of the catalog's top line.
Aggregate margin: 8.82%. Average delivery risk: >58%.
These products are not commercial threats, they are operational dead weight.
Eliminating them removes nearly a quarter of the catalog while protecting 97.8% of total revenue.
Affected brands include Under Armour (x2), ENO, Bridgestone, and Adidas.

**F-013 - 6.8% of Products Generate 80% of All Profit**
Just 8 products out of 118 drive 80% of total profit, the catalog exceeds Pareto concentration severely.
The remaining 110 products compete for the final 20% of margin while consuming the majority of operational bandwidth.
Critical fragility: if any of these 8 core SKUs faces supplier disruption or logistics failure, the business's profit base collapses entirely.
This is the single most important structural finding of the audit.

**F-014 - Composite Risk Scoring Confirms the Audit's Worst Offenders**
SOLE E25 (77.9) and SOLE E35 (66.7) rank as the two most toxic assets despite sitting in different quadrants.
Top 10 risk products are dominated by recognized premium brands: Nike, Under Armour, Garmin, Bushnell, Bridgestone.
The business is subsidizing brand names through discounts while absorbing chronic operational failure costs on those exact SKUs.
Single-dimension catastrophic failure (SOLE E35's margin) is equally dangerous as multi-dimension consistent failure (Bushnell's delivery risk).

**F-015 - Operational Metrics Only Predict Margin in Combination**
Discount dependency alone: no significant relationship with margin (r = −0.032, p = 0.734).
Delivery risk alone: no significant relationship with margin (r = −0.064, p = 0.491).
Composite risk score: significant negative relationship with margin (r = −0.570, p < 0.001).
No single operational failure predicts profit destruction. Only their convergence does.
This statistically validates the composite scoring model and the multi-dimensional audit approach.

**F-016 - Quadrant Model Represents Statistically Distinct Populations**
Kruskal-Wallis confirms quadrant separation is not arbitrary: margin (p = 4.43e-19), delivery risk (p = 5.47e-19).
Mann-Whitney pairwise confirms Cash Generators and Cut Candidates are from completely different distributions (p = 2.08e-10).
Every product elimination recommendation made from this model is acting on mathematically confirmed failure, not subjective judgment.

**F-017 - Statistical Outlier Confirmation of Toxic and Elite SKUs**
IQR analysis confirms SOLE E35, SOLE E25, and GoPro HERO3+ as statistically anomalous margin failures, below the 2.80% normal lower bound.
Their failure is systemic, not cyclical or random.
20 products exceed the upper profit bound of $7,970, but only the top 8 generate between $296K and $731K each, operating in a completely separate statistical stratosphere from the remaining catalog.
The business's profit structure is held together by 8 statistical anomalies at the top while 3 confirmed anomalies actively destroy value at the bottom.

