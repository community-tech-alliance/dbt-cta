select
    id,
    name,
    created_at,
    sort_order,
    updated_at
from {{ source('cta','contact_statuses_base') }}
