Why did you use dbt instead of writing everything in BigQuery?

Why did you choose a star schema?

Why did you separate staging and marts?

Why is the grain of your fact table one order and not one order item?

Why did you create this KPI instead of another one?

## Session Notes — Fact Table Design

- Renamed user_id → customer_id for business-oriented modeling
- Changed status indicators from INT64 to BOOLEAN
- Discussed FLOAT64 vs NUMERIC for monetary fields
- Kept IDs as INT64 for join efficiency
- Regenerated dbt documentation after schema updates