-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_organizations_ab1') }}
select
    _airbyte_users_hashid,
    cast(name as 
    string
) as name,
    cast(title as 
    string
) as title,
    cast(primary as boolean) as primary,
    cast(customType as 
    string
) as customType,
    cast(description as 
    string
) as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from {{ ref('users_organizations_ab1') }}
where 1 = 1