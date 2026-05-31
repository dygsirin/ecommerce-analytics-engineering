select
    order_item_id,
    order_id,
    user_id,
    product_id,
    sale_price,
    status,
    created_at,
    shipped_at,
    delivered_at,
    returned_at,

    case when status = 'Returned' then 1 else 0 end as is_returned,
    case when status = 'Cancelled' then 1 else 0 end as is_cancelled,
    case when status = 'Shipped' then 1 else 0 end as is_shipped,
    case when status = 'Complete' then 1 else 0 end as is_completed

from {{ ref('stg_order_items') }}