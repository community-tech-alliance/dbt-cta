{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to cast each column to its adequate SQL type converted from the JSON
-- schema type
-- depends_on: {{ ref("van_shifts_ab1") }}

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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref("van_shifts_ab1") }}
-- van_shifts
where 1 = 1
