-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_relations_ab1') }}
select
    _airbyte_users_hashid,
    cast(
        type as
        string
    ) as type,
    cast(
        value as
        string
    ) as value,
    cast(
        customType as
        string
    ) as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('users_relations_ab1') }}
where 1 = 1
