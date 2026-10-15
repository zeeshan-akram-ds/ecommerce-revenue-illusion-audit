# The Profit Leak Diagnostic

### What a $35M Catalog's Revenue Report Doesn't Show You

**An audit-grade profitability and operational risk framework for D2C brands and Shopify operators whose revenue is growing while margins quietly shrink.**

[![View Full Report (PDF)](https://img.shields.io/badge/Full%20Report-PDF-red)](reports/The_Profit_Leak_Diagnostic.pdf)

[![Dashboard Walkthrough](https://img.shields.io/badge/Dashboard-Video%20Walkthrough-blue)](https://youtu.be/BtNOyrPLW7o)

[![Book a Diagnostic Call](https://img.shields.io/badge/Book%20a%20Call-Calendly-green)](https://calendly.com/zeeshanakram/data-diagnostic)

> **Current version: v1.1 (October 2026).** The original report and README are preserved at the `v1.0` tag. See [REVISIONS.md](REVISIONS.md) for what changed and why.

---

## The Verdict

This catalog generates $35.2M in revenue across 180,519 transactions. On paper, that looks like a healthy business.

It isn't. Every single one of its 118 products has recorded at least one loss-making order. Just 8 products generate 84.5% of all profit. 28 products combine weak margins with high delivery failure and earn 2.2% of revenue. The first thing a revenue report hides is how concentrated and how fragile the profit actually is.

Revenue is not the issue. Mistaking revenue for business health is.

This repository is the full technical build behind that finding: the SQL warehouse, the statistical validation, the scenario models, and the dashboard all reproducible, all traceable back to ground-truth queries, none of it a guess dressed up as a conclusion.

\---

## See It In Action

|Dashboard|Report|
|-|-|
|!\[Dashboard Overview](assets/dashboard\_screenshots/dashboard-1.png)|!\[Report Cover](assets/report\_figures/cover\_image.png)|

🎥 [**Watch the full dashboard walkthrough →**](https://youtu.be/BtNOyrPLW7o) <br>
📄 [**Read the 9-page client report →**](reports/The_Profit_Leak_Diagnostic.pdf)

*(More dashboard pages and report figures are in `assets/dashboard\_screenshots/` and `assets/report\_figures/`.)*

\---

## What the Audit Found

### The Revenue Trap

44 products show strong revenue and weak or negative profit at the same time. The SOLE E35 Elliptical ranks 36th out of 118 by revenue and dead last in profit. Two products (SOLE E35, SOLE E25) are net-negative across their *entire three-year history*, not just on a bad day.

!\[Revenue Trap](assets/report\_figures/revenue\_trap\_section.png)

### The Discounting Illusion

93–97% of orders across nearly the entire catalog require a discount to convert. That's not a seasonal push, it's the default operating model. Statistical testing found no significant relationship between discount depth and margin (p = 0.73), so discount depth does not explain which products earn less. Even the top 4 revenue products need a discount on 94.4% of their orders, and 18.5% of their orders lose money outright.

!\[Discounting Illusion](assets/report\_figures/discount\_dependency.png)

### The Cost of Premium Shipping

First Class shipping arrives late **100% of the time**, averaging a full day behind schedule. Standard Class, the cheapest tier, is the most reliable method in the catalog. Customers paying the most for speed are getting the worst experience the business offers. A rate of exactly 100% with a uniform one-day gap suggests the promised delivery window may be mis-set, not only the process (a hypothesis to confirm from the delay distribution).

!\[Shipping Reality](assets/report\_figures/shipping\_reality.png)

### 28 Low-Performing SKUs (Cut Candidates)

28 products combine weak margins with high delivery failure while generating just 2.2% of total revenue, spread across 23 different categories: not one bad supplier, but scattered drag across nearly half the catalog's taxonomy. In aggregate they still contribute roughly $67K (1.8%) of profit. The data shows they are weak, not why. The report recommends sorting them by cause (new or seasonal, cost or discount, delivery, or genuinely dead) before cutting any. Savings in handling, storage and support are not measured in this dataset.

!\[Low-performing SKU triage](assets/report\_figures/zombie\_triage.png)

### The 8 Products Running the Business

8 products out of 118 generate 84.5% of all profit, a single point of failure wearing a 118-product disguise. A 20% margin shock to just those 8 (a plausible supplier or logistics disruption, modeled) wipes out **$643,000**, nearly 17% of total company profit, in one move. That is more than the other 110 products earn combined.

!\[Profit Concentration](assets/report\_figures/profit\_revenue\_concentration.png)

### What Happens If Nothing Changes

Three scenarios were modeled against this catalog to quantify the cost of inaction, run end-to-end in `notebooks/04\_scenario\_simulation.ipynb`:

|Scenario|Action|Financial Impact|
|-|-|-|
|**A: Zombie SKU Elimination**|Cut all 28 Cut Candidates|–$67K profit (operational savings not measured)|
|**B: Core SKU Disruption**|20% margin shock to the top 8 SKUs|–$643K profit (16.9% of total)|
|**C: Compounded Operational Stress**|+10% discount dependency, +15% delivery risk|–$181K profit (directional estimate)|

!\[Scenario Comparison](assets/report\_figures/scenario\_comparison.png)

\---

## The Analytical Deliverables

This isn't a set of charts, it's a decision engine built from three layers:

1. **SKU Quadrant Classification**: every product mapped into one of four operational quadrants (*Cash Generators, Operational Risks, Underperformers, Cut Candidates*) using catalog medians, not arbitrary thresholds.
2. **Revenue Trap Detection**: products with high revenue rank but low/negative profit rank, surfaced through rank-divergence analysis.
3. **Composite Risk Score (0–100)**: a normalized, equally-weighted blend of delivery failure, discount dependency, and rank divergence per SKU. Statistically validated as a predictor of margin collapse (r = -0.57, p < 0.001) where no single metric alone is predictive.

Every finding above is tagged by evidence strength, **Confirmed Evidence** (p < 0.05), **Directional Signal** (0.05 ≤ p < 0.10), or **Observation**, so nothing is presented with more certainty than the data supports.

\---

## Methodology \& Architecture

Built as a strict, reproducible three-phase pipeline not a single notebook with a chart at the end.

**Phase 1: Data Engineering \& Ground Truth (PostgreSQL)** <br>
Raw transactional data mapped into a 4-table star schema (`fact\_orders`, `dim\_product`, `dim\_region`, `dim\_date`). SQL is the *only* source of ground-truth KPIs revenue, net profit %, delivery risk rate per product and category. Fraudulent and canceled orders are excluded by a hard filter; every inclusion/exclusion decision (pending payments, low-volume products, extreme-loss records) is logged and justified in `docs/decision\_log.md`.

**Phase 2: Validation \& Quadrant Modeling (Python / Pandas)** <br>
SQL outputs reconciled in Python to confirm 0% data loss. Distributional analysis exposed extreme right-skew across revenue and profit, which directly shaped every modeling decision downstream medians over means, non-parametric tests over parametric ones.

**Phase 3: Statistical Proof (SciPy)** <br>
Shapiro-Wilk confirmed non-normality across all key metrics, so the audit relies on Spearman rank correlation, Kruskal-Wallis H-tests, Mann-Whitney U, and IQR outlier detection throughout rank-based methods that don't assume a bell curve that the data doesn't have. Quadrant separation alone is confirmed by Kruskal-Wallis at p = 4.43e-19 for margin and p = 5.47e-19 for delivery risk.

**Phase 4: Scenario Simulation** <br>
Validated findings converted into dollar-denominated business consequences (see scenario table above), so the recommendations aren't just "this SKU is risky" but "this SKU costs you $X if you do nothing."

Full reasoning for every modeling choice like quadrant axis selection, risk score weighting, alpha thresholds, scenario assumptions is documented in [`docs/decision\_log.md`](docs/decision_log.md).

\---

## Project Structure

```text
├── assets/
│   ├── dashboard\_screenshots/    # Power BI dashboard pages + walkthrough video
│   ├── linkedin\_assets/          # Carousel and launch visuals
│   └── report\_figures/           # Chart figures used in the client report
│
├── data/
│   ├── raw/                      # Raw transaction exports (not tracked in Git)
│   ├── processed/                # Cleaned SQL outputs
│   ├── sample/                   # Sample data
│   └── export/                   # Final exported CSVs / Excel
│
├── docs/                         # Decision log, KPI framework, methodology, assumptions (13 files)
│
├── notebooks/
│   ├── 01\_validation\_and\_eda.ipynb          # Distribution and temporal trend analysis
│   ├── 02\_profitability\_analysis.ipynb      # Quadrant modeling and Pareto analysis
│   ├── 03\_statistical\_validation.ipynb      # Non-parametric hypothesis testing
│   └── 04\_scenario\_simulation.ipynb         # Validated findings converted to financial impact
│
├── powerbi/
│   ├── dashboard/                # Power BI project (.pbip) full multi-page dashboard
│   └── theme.json                # Custom "Revenue Rank Reality" color theme \& typography
│
├── reports/
│   └── The\_Profit\_Leak\_Diagnostic.pdf        # Client-facing diagnostic (v1.1, 9 pages)
│
├── sql/
│   ├── 01\_raw\_import/            # DDL for raw data
│   ├── 02\_schema\_setup/          # Dimensional model creation
│   ├── 03\_quality\_audit/         # Integrity and null checks
│   ├── 04\_dimension\_builds/      # Dim tables (Product, Region, Date)
│   ├── 05\_fact\_builds/           # Fact table (Orders)
│   ├── 06\_validation/            # Foreign key and grain tests
│   └── 07\_kpi\_queries/           # Final analytical outputs feeding Python
│
├── src/                          # Environment configs and Python scripts
│
├── REVISIONS.md                  # What changed between v1.0 and v1.1, and why
├── requirements.txt
├── .gitignore
├── LICENSE
└── README.md
```

\---

## Run This Audit on Your Store

I run this exact diagnostic for e-commerce operators who need to know which SKUs are actually driving growth and which ones are quietly bleeding cash. If decisions in your business are being made off a revenue leaderboard, there's a real chance you're protecting the wrong products and cutting the wrong costs.

The deliverable isn't a generic dashboard, it's specific, statistically defensible interventions: which SKUs to protect, which to investigate before cutting, and what each path costs you in dollars if you do nothing.

### Get in Touch

* **Email:** [zeeshanakram1704@gmail.com](mailto:zeeshanakramds@gmail.com)
* **LinkedIn:** [linkedin.com/in/zeeshan-akram-ds](https://www.linkedin.com/in/zeeshan-akram-ds/)
* **Portfolio / Case Studies:** [Personal Website](https://zeeshan-portfolio-swart.vercel.app/)
* **Book a free 30-minute profit call:** [calendly.com/zeeshanakram/data-diagnostic](https://calendly.com/zeeshanakram/data-diagnostic)

\---

*Licensed under the terms in* [*LICENSE*](LICENSE)*.*

