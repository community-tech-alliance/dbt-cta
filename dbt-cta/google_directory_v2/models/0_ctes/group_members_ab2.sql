-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('group_members_ab1') }}
select
    cast(
        id as
        string
    ) as id,
    cast(
        kind as
        string
    ) as kind,
    cast(
        role as
        string
    ) as role,
    cast(
        type as
        string
    ) as type,
    cast(
        email as
        string
    ) as email,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('group_members_ab1') }}
where 1 = 1
