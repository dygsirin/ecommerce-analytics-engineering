select
    id as user_id,
    age,
    gender,
    city,
    state,
    country,
    traffic_source,
    created_at
from {{ source('thelook', 'users') }}