{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}

with
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_events_ab1 as (

        -- SQL model to parse JSON blob stored in a single column and extract into
        -- separated field columns as described by the JSON Schema
        -- depends_on: {{ source("cta", "_airbyte_raw_van_events" ) }}
        select
            json_extract_scalar(_airbyte_data, "$['id']") as id,
            json_extract_scalar(_airbyte_data, "$['van_id']") as van_id,
            json_extract_scalar(_airbyte_data, "$['event_id']") as event_id,
            json_extract_scalar(_airbyte_data, "$['committee_id']") as committee_id,
            json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
            json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
            json_extract_scalar(
                _airbyte_data, "$['sync_aggregation']"
            ) as sync_aggregation,
            json_extract_scalar(
                _airbyte_data, "$['event_campaign_id']"
            ) as event_campaign_id,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from {{ source("cta", "_airbyte_raw_van_events") }} as table_alias
        -- van_events
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_events_ab2 as (

        -- SQL model to cast each column to its adequate SQL type converted from the
        -- JSON schema type
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_events_ab1
        select
            cast(id as int64) as id,
            cast(van_id as int64) as van_id,
            cast(event_id as int64) as event_id,
            cast(committee_id as int64) as committee_id,
            cast(nullif(created_date, '') as timestamp) as created_date,
            cast(nullif(modified_date, '') as timestamp) as modified_date,
            cast(sync_aggregation as string) as sync_aggregation,
            cast(event_campaign_id as int64) as event_campaign_id,
            _airbyte_ab_id,
            _airbyte_emitted_at,
            current_timestamp() as _airbyte_normalized_at
        from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_events_ab1
        -- van_events
        where 1 = 1

    ),
    __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_events_ab3 as (

        -- SQL model to build a hash column based on the values of this record
        -- depends_on:
        -- __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_events_ab2
        select
            to_hex(
                md5(
                    cast(
                        concat(
                            coalesce(cast(id as string), ''),
                            '-',
                            coalesce(cast(van_id as string), ''),
                            '-',
                            coalesce(cast(event_id as string), ''),
                            '-',
                            coalesce(cast(committee_id as string), ''),
                            '-',
                            coalesce(cast(created_date as string), ''),
                            '-',
                            coalesce(cast(modified_date as string), ''),
                            '-',
                            coalesce(cast(sync_aggregation as string), ''),
                            '-',
                            coalesce(cast(event_campaign_id as string), '')
                        ) as string
                    )
                )
            ) as _airbyte_van_events_hashid,
            tmp.*
        from
            __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_events_ab2 tmp
        -- van_events
        where 1 = 1

    )  -- Final base SQL model
-- depends_on: __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_events_ab3
select
    id,
    van_id,
    event_id,
    committee_id,
    created_date,
    modified_date,
    sync_aggregation,
    event_campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_van_events_hashid
from __dbt__cte___airbyte_org_7e6abb14a314439581d38bb69eaa0083_van_events_ab3
-- van_events from {{ source("cta", "_airbyte_raw_van_events" ) }}
-- where
--     1 = 1


--     and cast(_airbyte_emitted_at as timestamp)
--     >= cast('2022-11-04 23:50:15.399000+00:00' as timestamp)

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

-- before edits: 0 records in base, 0 in partner
-- after adding prefix/suffix: 