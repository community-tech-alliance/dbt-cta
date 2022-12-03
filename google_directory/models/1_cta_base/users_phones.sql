
with __dbt__cte__users_phones_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users.`users`

select
    _airbyte_users_hashid,
    json_extract_scalar(phones, "$['type']") as type,
    json_extract_scalar(phones, "$['value']") as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users.`users` as table_alias
-- phones at users/phones
cross join unnest(phones) as phones
where 1 = 1
and phones is not null

),  __dbt__cte__users_phones_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__users_phones_ab1
select
    _airbyte_users_hashid,
    cast(type as 
    string
) as type,
    cast(value as 
    string
) as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from __dbt__cte__users_phones_ab1
-- phones at users/phones
where 1 = 1

),  __dbt__cte__users_phones_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__users_phones_ab2
select
    to_hex(md5(cast(concat(coalesce(cast(_airbyte_users_hashid as 
    string
), ''), '-', coalesce(cast(type as 
    string
), ''), '-', coalesce(cast(value as 
    string
), '')) as 
    string
))) as _airbyte_phones_hashid,
    tmp.*
from __dbt__cte__users_phones_ab2 tmp
-- phones at users/phones
where 1 = 1

)-- Final base SQL model
-- depends_on: __dbt__cte__users_phones_ab3
select
    _airbyte_users_hashid,
    type,
    value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_phones_hashid
from __dbt__cte__users_phones_ab3
-- phones at users/phones from `prod8b61f23e`.cta_tech_app_users.`users`
where 1 = 1

    
