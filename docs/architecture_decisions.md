# ADR-001: Use dbt Instead of BigQuery Scripts
## Decision

Use dbt to manage transformations rather than maintaining standalone SQL scripts.

## Reasoning
Version control through Git.
Modular SQL models.
Built-in testing.
Documentation generation.
Dependency management through ref().
## Alternatives Considered
Standalone SQL files executed manually in BigQuery.
Stored procedures.
## Why Rejected
Harder to maintain.
No lineage tracking.
More difficult testing.

# ADR-002: Use a Staging Layer
## Decision

Create staging models before fact and dimension tables.

## Reasoning
Standardize column names.
Handle data quality issues once.
Keep business logic out of raw models.
Improve model reusability.
## Alternatives Considered
Transform raw tables directly into marts.
## Why Rejected
Logic becomes duplicated across models.
Harder to debug and maintain.

# ADR-003: Use a Star Schema
## Decision

Create fact and dimension tables instead of a single denormalized table.

## Reasoning
Industry-standard analytical design.
Easier BI tool integration.
Better query performance.
Clear separation between facts and attributes.
## Alternatives Considered
One large flattened table.
## Why Rejected
Repeated customer and product attributes.
Harder to maintain.
Less scalable.

# ADR-004: Separate Raw Sources from Business Models

## Decision

Create staging models that mirror source tables before building analytical models.

## Reasoning

* Creates a clear separation between raw data and business logic.
* Makes downstream models easier to understand and maintain.
* Reduces duplicated transformations.
* Allows source-system changes to be handled in one place.

## Alternatives Considered

Build fact and dimension tables directly from source tables.

## Why Rejected

Business logic becomes tightly coupled to raw data structures, making maintenance more difficult.

# ADR-005: Exclude Personally Identifiable User Attributes

## Decision

Exclude `first_name` and `last_name` from analytical models.

## Reasoning

* No analytical value for business reporting.
* Not required for joins.
* Not required for segmentation.
* Reduces unnecessary data exposure.
* Keeps models focused on analytical attributes.

## Alternatives Considered

Include all source columns in staging models.

## Why Rejected

Introduces irrelevant attributes and increases model complexity without improving analysis.


# ADR-006: Use Order Item Grain for the Primary Fact Table

## Decision

Build the primary fact table at the order-item level, with one row representing a product purchased within an order.

## Reasoning

* Supports product-level analysis.
* Supports category and brand performance analysis.
* Supports return-rate analysis.
* Supports customer lifetime value calculations.
* Can be aggregated to order level when needed.

## Alternatives Considered

Use one row per order.

## Why Rejected

Order-level grain loses product-level detail and limits analytical flexibility for product, category, and brand reporting.

# ADR-007: Build Fact Table from Order Items Rather Than Orders

## Decision

Use `stg_order_items` as the primary source for the fact table.

## Reasoning

- Contains the desired analytical grain.
- Includes revenue information.
- Includes fulfillment and return status.
- Includes all relevant timestamps.
- Avoids unnecessary joins.

## Alternatives Considered

Join `stg_orders` into the fact table.

## Why Rejected

The additional attributes (`gender`, `num_of_item`) are either:
- Better sourced from customer dimensions, or
- Derivable through aggregation.

# ADR-008: Avoid storing derivable aggregations in fact tables

## Decision

Do not include `num_of_items` in the fact table.

## Reasoning

- It is fully derivable from order_items
- Including it introduces redundancy
- Increases risk of inconsistency across models
- Violates "single source of truth" principle

