
with __dbt__cte__groups_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source("cta", "_airbyte_raw_groups" ) }}
select
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['etag']") as etag,
    json_extract_scalar(_airbyte_data, "$['kind']") as kind,
    json_extract_scalar(_airbyte_data, "$['name']") as name,
    json_extract_scalar(_airbyte_data, "$['email']") as email,
    json_extract_scalar(_airbyte_data, "$['description']") as description,
    json_extract_scalar(_airbyte_data, "$['adminCreated']") as adminCreated,
    json_extract_scalar(_airbyte_data, "$['directMembersCount']") as directMembersCount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from {{ source("cta", "_airbyte_raw_groups" ) }} as table_alias
-- groups
where 1 = 1

),  __dbt__cte__groups_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__groups_ab1
select
    cast(id as 
    string
) as id,
    cast(etag as 
    string
) as etag,
    cast(kind as 
    string
) as kind,
    cast(name as 
    string
) as name,
    cast(email as 
    string
) as email,
    cast(description as 
    string
) as description,
    cast(adminCreated as boolean) as adminCreated,
    cast(directMembersCount as 
    string
) as directMembersCount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at
from __dbt__cte__groups_ab1
-- groups
where 1 = 1

)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__groups_ab2
select
    to_hex(md5(cast(concat(coalesce(cast(id as 
    string
), ''), '-', coalesce(cast(etag as 
    string
), ''), '-', coalesce(cast(kind as 
    string
), ''), '-', coalesce(cast(name as 
    string
), ''), '-', coalesce(cast(email as 
    string
), ''), '-', coalesce(cast(description as 
    string
), ''), '-', coalesce(cast(adminCreated as 
    string
), ''), '-', coalesce(cast(directMembersCount as 
    string
), '')) as 
    string
))) as _airbyte_groups_hashid,
    tmp.*
from __dbt__cte__groups_ab2 tmp
-- groups
where 1 = 1
