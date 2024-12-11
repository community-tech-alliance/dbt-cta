-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_name_ab1') }}
select
    _airbyte_users_hashid,
    cast(
        fullName as
        string
    ) as fullName,
    cast(
        givenName as
        string
    ) as givenName,
    cast(
        familyName as
        string
    ) as familyName,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref('users_name_ab1') }}
where 1 = 1
