-- Final base SQL model
-- depends_on: {{ ref('users_organizations_ab3') }}
select
    _airbyte_users_hashid,
    name,
    title,
    primary,
    customType,
    description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_organizations_hashid
from {{ ref('users_organizations_ab3') }}
where 1 = 1