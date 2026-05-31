select
    id as product_id,
    cost,
    category,
    name,
    brand,
    retail_price,
    department,
    sku
from {{ source('thelook', 'products') }}