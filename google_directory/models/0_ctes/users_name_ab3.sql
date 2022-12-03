
with __dbt__cte__users_name_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users.`users`
select
    _airbyte_users_hashid,
    json_extract_scalar(name, "$['fullName']") as fullName,
    json_extract_scalar(name, "$['givenName']") as givenName,
    json_extract_scalar(name, "$['familyName']") as familyName,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users.`users` as table_alias
-- name at users/name
where 1 = 1
and name is not null

),  __dbt__cte__users_name_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__users_name_ab1
select
    _airbyte_users_hashid,
    cast(fullName as 
    string
) as fullName,
    cast(givenName as 
    string
) as givenName,
    cast(familyName as 
    string
) as familyName,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from __dbt__cte__users_name_ab1
-- name at users/name
where 1 = 1

)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__users_name_ab2
select
    to_hex(md5(cast(concat(coalesce(cast(_airbyte_users_hashid as 
    string
), ''), '-', coalesce(cast(fullName as 
    string
), ''), '-', coalesce(cast(givenName as 
    string
), ''), '-', coalesce(cast(familyName as 
    string
), '')) as 
    string
))) as _airbyte_name_hashid,
    tmp.*
from __dbt__cte__users_name_ab2 tmp
-- name at users/name
where 1 = 1
