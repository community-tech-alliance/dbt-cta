
with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_shifts_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_van_shifts" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['van_id']") as van_id,
            json_extract_scalar(_airbyte_data, "$['end_date']") as end_date,
            json_extract_scalar(_airbyte_data, "$['start_date']") as start_date,
            json_extract_scalar(_airbyte_data, "$['timeslot_id']") as timeslot_id,
            json_extract_scalar(_airbyte_data, "$['committee_id']") as committee_id,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            json_extract_scalar(
                _airbyte_data, "$['sync_aggregation']"
            ) as sync_aggregation,
            json_extract_scalar(
                _airbyte_data, "$['van_event_van_id']"
            ) as van_event_van_id,
            json_extract_scalar(
                _airbyte_data, "$['event_campaign_id']"
            ) as event_campaign_id,
            json_extract_scalar(
                _airbyte_data, "$['van_event_campaign_timezone']"
            ) as van_event_campaign_timezone,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_van_shifts") }} as table_alias
        -- van_shifts
        where 1 = 1

    -- SQL model to cast each column to its adequate SQL type converted from the JSON
    -- schema type
    )
-- depends_on: __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_shifts_ab1
select
    cast(id as int64) as id,
    cast(van_id as int64) as van_id,
    cast(nullif(end_date, '') as timestamp) as end_date,
    cast(nullif(start_date, '') as timestamp) as start_date,
    cast(timeslot_id as int64) as timeslot_id,
    cast(committee_id as int64) as committee_id,
    cast(nullif(created_date, '') as timestamp) as created_date,
    cast(nullif(modified_date, '') as timestamp) as modified_date,
    cast(sync_aggregation as string) as sync_aggregation,
    cast(van_event_van_id as int64) as van_event_van_id,
    cast(event_campaign_id as int64) as event_campaign_id,
    cast(van_event_campaign_timezone as string) as van_event_campaign_timezone,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_shifts_ab1
-- van_shifts
where 1 = 1
