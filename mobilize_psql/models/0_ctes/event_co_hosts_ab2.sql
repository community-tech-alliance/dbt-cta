
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_co_hosts_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_event_co_hosts" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['email']") as email,
            json_extract_scalar(_airbyte_data, "$['user_id']") as user_id,
            json_extract_scalar(_airbyte_data, "$['event_id']") as event_id,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_event_co_hosts") }} as table_alias
        -- event_co_hosts
        where 1 = 1

    -- SQL model to cast each column to its adequate SQL type converted from the JSON
    -- schema type
    )
-- depends_on:
-- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_co_hosts_ab1
select
    cast(id as int64) as id,
    cast(email as string) as email,
    cast(user_id as int64) as user_id,
    cast(event_id as int64) as event_id,
    cast(nullif(created_date, '') as timestamp) as created_date,
    cast(nullif(modified_date, '') as timestamp) as modified_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_event_co_hosts_ab1
-- event_co_hosts
where 1 = 1
