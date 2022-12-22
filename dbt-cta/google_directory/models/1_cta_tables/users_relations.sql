-- Final base SQL model
-- depends_on: {{ ref('users_relations_ab3') }}, {{ source('cta','users') }}
select
    _airbyte_users_hashid,
    type,
    value,
    customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_relations_hashid
from {{ ref('users_relations_ab3') }}
where 1 = 1

    
