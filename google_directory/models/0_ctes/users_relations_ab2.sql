
with __dbt__cte__users_relations_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users.`users`

select
    _airbyte_users_hashid,
    json_extract_scalar(relations, "$['type']") as type,
    json_extract_scalar(relations, "$['value']") as value,
    json_extract_scalar(relations, "$['customType']") as customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users.`users` as table_alias
-- relations at users/relations
cross join unnest(relations) as relations
where 1 = 1
and relations is not null

)-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__users_relations_ab1
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
from __dbt__cte__users_relations_ab1
-- relations at users/relations
where 1 = 1
