select
    id,
    name,
    hidden,
    group_id,
    created_at,
    updated_at,
    _airbyte_email_campaigns_hashid
from {{ ref('email_campaigns_base') }}