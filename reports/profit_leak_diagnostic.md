# The Profit Leak Diagnostic
### How 28 Products Are Bleeding $643K Out of a $35M Catalog

Zeeshan Akram · E-commerce Profit Analyst
DataCo Supply Chain Dataset · 180,519 transactions · 3 years

![Cover image](../assets/report_figures/cover_image.png)

---

## The Verdict

This catalog generates $35.2 million in revenue. On paper, that looks like a healthy business.

It isn't. Every single product in this catalog has recorded at least one loss-making order. Just 8 products generate 84.5% of all profit. 28 products are sitting in the catalog doing almost nothing but eating up warehouse space and customer service hours.

For nearly three years, revenue and profit moved sideways. Flat. No real growth, no real decline, just a business treading water. Then in January 2018, both collapsed off a cliff in the same month. That is not a seasonal dip. That is what happens when a fragile supply chain finally runs out of room to absorb its own problems.

Revenue is not the issue here. Mistaking revenue for business health is.

---

## The Revenue Trap: Products That Sell Well and Lose Money

![Revenue Trap section](../assets/report_figures/revenue_trap_section.png)

The SOLE E35 Elliptical ranks 36th out of 118 products by revenue. In profit, it ranks dead last. It loses money on every order while showing up as a respectable mid-tier seller on any standard sales report.

This is not one unlucky product. 44 products in this catalog follow the same pattern: strong revenue, weak or negative profit. If decisions in this business are being made off a revenue leaderboard, they are being made off the wrong list entirely.

The same pattern shows up in pure dollar terms too. The SOLE E35 and SOLE E25 Ellipticals are net negative across their entire three year history. Not one bad order. Three years of losing money, every time they sell.

---

## The Discounting Illusion

![Discounting Illusion](../assets/report_figures/discount_dependency.png)

Between 93% and 97% of orders across almost the entire catalog require a discount to sell. That is not a seasonal push or a growth tactic. That is the default state of the business.

It would be easy to assume heavier discounting is what's driving the weaker margins. It isn't. Statistical testing confirms zero correlation between discount frequency and margin erosion. Discounting is not the lever causing the damage here. It is simply the floor this business stands on every single day, and it means there is no quick pricing fix waiting to be pulled.

The uncomfortable part is what this means for the top sellers. The four highest-revenue products in the catalog are genuinely the most profitable in absolute dollars. But 94.4% of their orders require a discount to close, and 18.5% of those orders still lose money outright. The top of the catalog is not winning on merit. It is winning on subsidy.

---

## The Cost of Premium Shipping

![Cost of Premium Shipping](../assets/report_figures/shipping_reality.png)

First Class shipping arrives late 100% of the time. Every order, every time. Standard Class, the cheapest tier available, is the most reliable shipping method in the entire catalog.

Customers paying the most for speed are getting the worst experience this business offers. That is not a logistics footnote. That is a refund risk and a trust problem sitting quietly inside the fulfillment numbers, waiting to show up as a one star review.

---

## The 28 Products Doing Nothing for the Business

![Zombie SKUs Breakdown](../assets/report_figures/zombie_skus_visual.png)

28 products combine weak margins with high delivery failure while generating just 2.2% of total revenue. Cut every one of them and the business retains 97.8% of revenue and 98.2% of profit.

These 28 products are not clustered in one bad category or tied to one bad supplier. They are spread across 23 different categories, nearly half the entire product taxonomy. This is not a sourcing problem with one vendor. It is scattered, low-grade drag sitting across almost every corner of the catalog. Removing it costs almost nothing and frees up real operational room immediately.

---

## The Eight Products Running This Entire Business

![Profit Revenue Concentration](../assets/report_figures/profit_revenue_concentration.png)

8 products out of 118 generate 84.5% of all profit. That is not a diversified catalog. That is a single point of failure wearing a 118 product disguise.

We modeled what happens if just one of those 8 products gets hit with a supplier price increase or a logistics breakdown. A 20% margin hit to those 8 products alone wipes out $643,000, nearly 17% of total company profit in one move. The other 110 products cannot absorb that loss between them. There is no backup plan built into this catalog right now.

---

## What Happens If Nothing Changes

![Scenario Comparison](../assets/report_figures/scenario_comparison.png)

Three scenarios were run against this catalog to see what each path actually costs in dollars.

**Cutting the 28 weak products** costs $67,000 in profit and frees up roughly a quarter of operational bandwidth. Low risk, fast return, almost no downside.

**A disruption to the core 8 products** costs $643,000. This is the single largest financial exposure sitting inside this business today.

**Letting current conditions keep compounding**, more discounting, more late deliveries, costs an additional $181,000 in margin erosion. This is not a hypothetical. The data already shows these exact conditions worsening, not improving, across three full years. January 2018 is what that trajectory eventually looks like when nobody intervenes.

---

## What To Do Next

**1. Cut the 28 underperforming products now.**
Cost: $67,000 in profit. Return: a quarter of operational bandwidth freed immediately. This is the fastest, lowest-risk move available in this entire audit.

**2. Protect the core 8 products like they are the business. Because they are.**
Lock in supplier terms, prioritize their fulfillment, and stop touching their pricing without a clear reason. One disruption here threatens $643,000 in profit, more than the rest of the catalog combined could ever cover.

**3. Fix First Class shipping or pull it off the menu.**
A shipping tier that fails 100% of the time is not a minor operational hiccup. It is an active liability sitting on every order placed through it. Fix the fulfillment process behind it, or stop offering it until it works.

---

## Data Rigor & Methodology

This audit is built on 180,519 real order line transactions spanning three years of operating history, loaded into a structured PostgreSQL warehouse and checked for data quality at every stage before a single chart was built. Every number above was first established in SQL as ground truth, then independently reproduced and statistically tested in Python to confirm it holds up and is not just noise in the dataset.

Findings were only treated as confirmed once they passed hypothesis testing at a 95% confidence threshold. Where a relationship did not hold statistically, such as discount depth and margin, that absence was reported as plainly as the findings that did hold. Nothing in this report is a guess dressed up as a conclusion.

The full interactive dashboard is available here: ![Dashboard Preview](https://youtu.be/BtNOyrPLW7o)

The complete technical build, including every SQL query and Python notebook, is available here: ![GitHub Repo Link](https://github.com/zeeshan-akram-ds/ecommerce-revenue-illusion-audit)


---

## Let's Talk About Your Store

I run this exact diagnostic for e-commerce operators who need to know which SKUs are actually driving growth and which ones are quietly bleeding cash. If decisions in your business are being made off a revenue leaderboard, there is a real chance you are protecting the wrong products and cutting the wrong costs.

**Zeeshan Akram**
E-commerce Profit Analyst

Email: [zeeshanakramds@gmail.com](mailto:zeeshanakramds@gmail.com)
LinkedIn: [linkedin.com/in/zeeshan-akram-ds](https://www.linkedin.com/in/zeeshan-akram-ds/)
Book a Diagnostic Call: [calendly.com/zeeshanakram/data-diagnostic](https://calendly.com/zeeshanakram/data-diagnostic)