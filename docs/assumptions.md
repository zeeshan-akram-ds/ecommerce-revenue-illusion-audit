# Assumptions

## Inventory & Operational Proxy Assumptions

The dataset does not contain direct inventory, supplier, or warehouse fields.

The following metrics will therefore be engineered using proxy logic and documented transparently throughout the project:

| Engineered Metric | Proxy Logic |
|---|---|
| Inventory exposure | Estimated using sales velocity and order frequency |
| Days of inventory on hand | Derived from estimated inventory exposure and average sales volume |
| Reorder risk | Estimated from sales velocity and shipping delay patterns |
| Lead time proxy | Approximated using actual shipping duration fields |
| Holding cost | Estimated using standard e-commerce holding cost benchmarks |
| Operational drag | Estimated using delivery delays, discount depth, and negative profitability patterns |

These engineered metrics are directional analytical estimates rather than direct operational measurements.