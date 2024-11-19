-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('groups_ab1') }}
select
    cast(
        id as
        string
    ) as id,
    cast(
        etag as
        string
    ) as etag,
    cast(
        kind as
        string
    ) as kind,
    cast(
        name as
        string
    ) as name,
    cast(
        email as
        string
    ) as email,
    cast(
        description as
        string
    ) as description,
    cast(adminCreated as boolean) as adminCreated,
    cast(
        directMembersCount as
        string
    ) as directMembersCount,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('groups_ab1') }}
where 1 = 1
