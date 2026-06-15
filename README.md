# E-Commerce Revenue Illusion Audit: Exposing Hidden Margin Destruction

**A diagnostic analytics framework designed for D2C brands, Shopify store owners, and e-commerce founders to separate top-line vanity metrics from bottom-line reality.**

## The Business Problem
Many scaling e-commerce brands suffer from "The Revenue Illusion." The top-line grows, but net margins shrink. Dashboards show high sales volume, masking the fact that specific SKUs, shipping modes, or regions are actively destroying profit through late delivery penalties, operational friction, and chronic discount dependency. 

This project is a complete analytical audit of a $35.2M e-commerce dataset (180,000+ transactions), designed to locate the exact points of margin bleed and provide mathematically defensible recommendations for catalog pruning and operational restructuring.

## Key Discoveries
By moving beyond basic averages and applying statistical quadrant modeling, this audit revealed systemic operational failures hiding behind high revenue numbers:

* **The Pareto Extreme (Severe Concentration):** The business is propped up by a "black swan" core. Just **6.8% of the catalog (8 products)** generates **80% of total profit**. The remaining 110 products consume massive supply chain bandwidth for fractional returns.
* **The Expedited SLA Failure:** The supply chain is fundamentally incapable of supporting premium SLAs. "First Class" shipping has a **100% late delivery risk rate**, averaging a full day behind schedule. The cheapest tier ("Standard Class") is the most reliable. Every premium shipping order generates negative customer sentiment.
* **The "Zombie SKU" Reality:** 24% of the physical catalog sits in the "Cut Candidates" quadrant. These products combine weak unit economics with active operational failure (>58% delivery risk), yet they represent only 2.2% of total revenue. Amputating a quarter of the catalog would instantly streamline operations with near-zero top-line impact.
* **Discounting is a Structural Cost, Not a Lever:** Statistical correlation proved no relationship between discount depth and margin variance ($p = 0.73$). Because virtually every product requires a discount >94% of the time to move, discounting acts as a fixed baseline cost rather than a variable promotional tactic.

## The Analytical Deliverables
This framework does not just provide charts; it provides decision engines for founders.

1. **SKU Quadrant Classification:** Every product is mapped into four operational quadrants based on internal catalog medians: *Cash Generators, Operational Risks, Underperformers, and Cut Candidates.*
2. **The Revenue Trap Deep Dive:** Identification of products with massive rank divergence—items that rank high in revenue (e.g., Rank 36) but dead last in profit (e.g., Rank 118) due to hidden fulfillment costs. 
3. **Composite Risk Scoring:** A normalized 0-100 score for every SKU combining delivery failure rates, discount dependency, and rank divergence. Statistically validated ($p < 0.0001$) as a predictor of margin collapse.

## Methodology & Architecture
This audit was conducted using a strict, reproducible data engineering and statistical pipeline.

* **Phase 1: Data Engineering & Ground Truth (SQL)**
  * Raw transaction data mapped into a Dimensional Model (Star Schema) via PostgreSQL.
  * SQL used exclusively to generate the unalterable ground truth KPIs (Total Revenue, Net Profit %, Delivery Risk Rate) per product and category.
* **Phase 2: Validation & Quadrant Modeling (Python / Pandas)**
  * SQL outputs reconciled in Python to ensure 0% data loss.
  * Distributional analysis exposing extreme right-skew in revenue and profit.
  * Development of the 4-quadrant operational model and Pareto cumulative profit curves.
* **Phase 3: Statistical Proof (SciPy)**
  * E-commerce data is rarely normally distributed. Shapiro-Wilk tests confirmed severe non-normality across all metrics.
  * Applied robust non-parametric tests (Spearman Rank Correlation, Kruskal-Wallis H-Test, Mann-Whitney U, IQR Outlier Detection) to prove that failing quadrants represent genuinely different statistical populations, not just bad luck.

## Project Structure

```text
├── assets/
│   ├── dashboard_screenshots/    # Screenshots of Power BI / Tableau dashboards
│   ├── linkedin_assets/          # Visuals and graphics for LinkedIn posts
│   └── report_figures/           # High-quality charts and figures for reports
│
├── data/
│   ├── raw/                      # Raw transaction exports (not tracked in Git)
│   ├── processed/                # Cleaned and transformed data (SQL outputs)
│   ├── sample/                   # Sample datasets for development & testing
│   └── export/                   # Final exported files (CSVs, Excel, etc.)
│
├── docs/                         # Methodologies, decision logs, KPI definitions (13 files)
│
├── notebooks/
│   ├── 01_validation_and_eda.ipynb          # Distribution and temporal trend analysis
│   ├── 02_profitability_analysis.ipynb      # Quadrant modeling and Pareto analysis
│   ├── 03_statistical_validation.ipynb      # Non-parametric hypothesis testing
│   └── 04_scenario_simulation.ipynb         # Scenario simulation - converts validated findings into financial consequences (currently empty)
│
├── powerbi/                      # Power BI reports and .pbix files (currently empty)
│
├── reports/                      # Final reports and presentations (currently empty)
│
├── sql/
│   ├── 01_raw_import/            # DDL for raw data
│   ├── 02_schema_setup/          # Dimensional model creation
│   ├── 03_quality_audit/         # Integrity and null checks
│   ├── 04_dimension_builds/      # Dim tables (Product, Region, Date, etc.)
│   ├── 05_fact_builds/           # Fact table (Orders, etc.)
│   ├── 06_validation/            # Foreign key and grain tests
│   └── 07_kpi_queries/           # Final analytical outputs for Python
│
├── src/                          # Environment configurations and Python scripts
│
├── requirements.txt
├── .gitignore
├── LICENSE
└── README.md
```

## Work With Me

I am an independent data analyst specializing in helping e-commerce brands, D2C founders, and retail operators find the profit leaks in their supply chain and sales data. 

I do not deliver generic dashboards; I deliver **specific operational interventions backed by statistical proof**.

If your top-line revenue is growing but your margins are shrinking, let's run this audit on your data.

### Get in Touch

- **Email**: [Email](mailto:zeeshanakramds@gmail.com)
- **LinkedIn**: [LinkedIn Profile](https://www.linkedin.com/in/zeeshan-akram-ds/)
- **Portfolio / Case Studies**: [Personal Website](https://zeeshan-portfolio-swart.vercel.app/)
- **Book a 15-20 min Call**: [Calendly Link](https://calendly.com/zeeshanakram/data-diagnostic)

---

Open to consulting projects, fractional analytics roles, and collaborations.