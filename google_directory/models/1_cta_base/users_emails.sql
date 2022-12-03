
with __dbt__cte__users_emails_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users.`users`

select
    _airbyte_users_hashid,
    json_extract_scalar(emails, "$['type']") as type,
    json_extract_scalar(emails, "$['address']") as address,
    json_extract_scalar(emails, "$['primary']") as primary,
    json_extract_scalar(emails, "$['customType']") as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users.`users` as table_alias
-- emails at users/emails
cross join unnest(emails) as emails
where 1 = 1
and emails is not null

),  __dbt__cte__users_emails_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__users_emails_ab1
select
    _airbyte_users_hashid,
    cast(type as 
    string
) as type,
    cast(address as 
    string
) as address,
    cast(primary as boolean) as primary,
    cast(customType as 
    string
) as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from __dbt__cte__users_emails_ab1
-- emails at users/emails
where 1 = 1

),  __dbt__cte__users_emails_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__users_emails_ab2
select
    to_hex(md5(cast(concat(coalesce(cast(_airbyte_users_hashid as 
    string
), ''), '-', coalesce(cast(type as 
    string
), ''), '-', coalesce(cast(address as 
    string
), ''), '-', coalesce(cast(primary as 
    string
), ''), '-', coalesce(cast(customType as 
    string
), '')) as 
    string
))) as _airbyte_emails_hashid,
    tmp.*
from __dbt__cte__users_emails_ab2 tmp
-- emails at users/emails
where 1 = 1

)-- Final base SQL model
-- depends_on: __dbt__cte__users_emails_ab3
select
    _airbyte_users_hashid,
    type,
    address,
    primary,
    customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_emails_hashid
from __dbt__cte__users_emails_ab3
-- emails at users/emails from `prod8b61f23e`.cta_tech_app_users.`users`
where 1 = 1

    
and cast(_airbyte_emitted_at as 
    timestamp
) >=
    cast('2022-12-02 10:00:41+00:00' as 
    timestamp
)
    
