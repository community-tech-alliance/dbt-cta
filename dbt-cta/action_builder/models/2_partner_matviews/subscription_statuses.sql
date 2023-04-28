select
    id,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    campaign_id,
    created_by_id,
    _airbyte_subscription_statuses_hashid
from {{ source('cta','subscription_statuses_base') }}