select

    customer_id,
    country,
    traffic_source,
    created_at
    
from {{ ref('stg_users') }}