select
    order_item_id,
    order_id,
    user_id as customer_id,
    product_id,
    CAST(sale_price AS NUMERIC) AS sale_price,
    status,
    created_at,
    shipped_at,
    delivered_at,
    returned_at,

    case when status='Returned' then true else false end as is_returned,
    case when status='Cancelled' then true else false end as is_cancelled,
    case when status='Shipped' then true else false end as is_shipped,
    case when status='Complete' then true else false end as is_completed
    
from {{ ref('stg_order_items') }}