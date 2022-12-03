
with __dbt__cte__group_members_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: `prod8b61f23e`.cta_tech_app_users._airbyte_raw_group_members
select
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['kind']") as kind,
    json_extract_scalar(_airbyte_data, "$['role']") as role,
    json_extract_scalar(_airbyte_data, "$['type']") as type,
    json_extract_scalar(_airbyte_data, "$['email']") as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from `prod8b61f23e`.cta_tech_app_users._airbyte_raw_group_members as table_alias
-- group_members
where 1 = 1

),  __dbt__cte__group_members_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__group_members_ab1
select
    cast(id as 
    string
) as id,
    cast(kind as 
    string
) as kind,
    cast(role as 
    string
) as role,
    cast(type as 
    string
) as type,
    cast(email as 
    string
) as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from __dbt__cte__group_members_ab1
-- group_members
where 1 = 1

)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__group_members_ab2
select
    to_hex(md5(cast(concat(coalesce(cast(id as 
    string
), ''), '-', coalesce(cast(kind as 
    string
), ''), '-', coalesce(cast(role as 
    string
), ''), '-', coalesce(cast(type as 
    string
), ''), '-', coalesce(cast(email as 
    string
), '')) as 
    string
))) as _airbyte_group_members_hashid,
    tmp.*
from __dbt__cte__group_members_ab2 tmp
-- group_members
where 1 = 1
