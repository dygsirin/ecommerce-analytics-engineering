select
    id as order_item_id,
    order_id,
    user_id,
    product_id,
    inventory_item_id,
    sale_price,
    status,
    created_at,
    shipped_at,
    delivered_at,
    returned_at
from {{ source('thelook', 'order_items') }}