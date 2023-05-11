select
    _airbyte_emitted_at,
    id,
    name,
    hidden,
    group_id,
    created_at,
    updated_at
from {{ source('cta','email_campaigns_base') }}