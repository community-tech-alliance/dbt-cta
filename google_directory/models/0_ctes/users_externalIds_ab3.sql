
with __dbt__cte__users_externalIds_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users.`users`

select
    _airbyte_users_hashid,
    json_extract_scalar(externalIds, "$['type']") as type,
    json_extract_scalar(externalIds, "$['value']") as value,
    json_extract_scalar(externalIds, "$['customType']") as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users.`users` as table_alias
-- externalIds at users/externalIds
cross join unnest(externalIds) as externalIds
where 1 = 1
and externalIds is not null

),  __dbt__cte__users_externalIds_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__users_externalIds_ab1
select
    _airbyte_users_hashid,
    cast(type as 
    string
) as type,
    cast(value as 
    string
) as value,
    cast(customType as 
    string
) as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from __dbt__cte__users_externalIds_ab1
-- externalIds at users/externalIds
where 1 = 1

)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__users_externalIds_ab2
select
    to_hex(md5(cast(concat(coalesce(cast(_airbyte_users_hashid as 
    string
), ''), '-', coalesce(cast(type as 
    string
), ''), '-', coalesce(cast(value as 
    string
), ''), '-', coalesce(cast(customType as 
    string
), '')) as 
    string
))) as _airbyte_externalIds_hashid,
    tmp.*
from __dbt__cte__users_externalIds_ab2 tmp
-- externalIds at users/externalIds
where 1 = 1
