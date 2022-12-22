-- Final base SQL model
-- depends_on: {{ ref('users_phones_ab3') }}, {{ source('cta','users') }}
select
    _airbyte_users_hashid,
    type,
    value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_phones_hashid
from {{ ref('users_phones_ab3') }}
where 1 = 1

    
