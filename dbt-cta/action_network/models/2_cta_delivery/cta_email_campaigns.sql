select
    id,
    name,
    hidden,
    group_id,
    created_at,
    updated_at,
    _airbyte_email_campaigns_hashid
from {{ source('cta','email_campaigns_base') }}
