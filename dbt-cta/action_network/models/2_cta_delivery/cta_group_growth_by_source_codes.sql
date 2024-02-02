select
    id,
    end_at,
    group_id,
    start_at,
    created_at,
    updated_at,
    source_code,
    total_count,
    new_users_count,
    last_subscription_id,
    _airbyte_group_growth_by_source_codes_hashid
from {{ source('cta','group_growth_by_source_codes_base') }}
