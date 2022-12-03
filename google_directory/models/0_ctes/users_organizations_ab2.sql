
with __dbt__cte__users_organizations_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users.`users`

select
    _airbyte_users_hashid,
    json_extract_scalar(organizations, "$['name']") as name,
    json_extract_scalar(organizations, "$['title']") as title,
    json_extract_scalar(organizations, "$['primary']") as primary,
    json_extract_scalar(organizations, "$['customType']") as customType,
    json_extract_scalar(organizations, "$['description']") as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users.`users` as table_alias
-- organizations at users/organizations
cross join unnest(organizations) as organizations
where 1 = 1
and organizations is not null

)-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__users_organizations_ab1
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
from __dbt__cte__users_organizations_ab1
-- organizations at users/organizations
where 1 = 1
