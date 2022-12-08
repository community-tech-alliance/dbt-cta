
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_timeslots_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_timeslots" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['end_date']") as end_date,
            json_extract_scalar(_airbyte_data, "$['event_id']") as event_id,
            json_extract_scalar(_airbyte_data, "$['start_date']") as start_date,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['deleted_date']") as deleted_date,
            json_extract_scalar(_airbyte_data, "$['max_attendees']") as max_attendees,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_timeslots") }} as table_alias
        -- timeslots
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_timeslots_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_timeslots_ab1
        select
            cast(id as int64) as id,
            cast(nullif(end_date, '') as timestamp) as end_date,
            cast(event_id as int64) as event_id,
            cast(nullif(start_date, '') as timestamp) as start_date,
            cast(nullif(created_date, '') as timestamp) as created_date,
            cast(nullif(deleted_date, '') as timestamp) as deleted_date,
            cast(max_attendees as int64) as max_attendees,
            cast(nullif(modified_date, '') as timestamp) as modified_date,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_timeslots_ab1
        -- timeslots
        where 1 = 1

    )  -- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_timeslots_ab2
select
    to_hex(
        md5(
            cast(
                concat(
                    coalesce(cast(id as string), ''),
                    '-',
                    coalesce(cast(end_date as string), ''),
                    '-',
                    coalesce(cast(event_id as string), ''),
                    '-',
                    coalesce(cast(start_date as string), ''),
                    '-',
                    coalesce(cast(created_date as string), ''),
                    '-',
                    coalesce(cast(deleted_date as string), ''),
                    '-',
                    coalesce(cast(max_attendees as string), ''),
                    '-',
                    coalesce(cast(modified_date as string), '')
                ) as string
            )
        )
    ) as _airbyte_timeslots_hashid,
    tmp.*
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_timeslots_ab2 tmp
-- timeslots
where 1 = 1
