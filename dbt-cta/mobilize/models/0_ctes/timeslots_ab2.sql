{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to cast each column to its adequate SQL type converted from the JSON
-- schema type
-- depends_on: {{ ref("timeslots_ab1")}}

select
    cast(id as int64) as id,
    cast(nullif(end_date, '') as timestamp) as end_date,
    cast(event_id as int64) as event_id,
    cast(nullif(start_date, '') as timestamp) as start_date,
    cast(nullif(created_date, '') as timestamp) as created_date,
    cast(nullif(deleted_date, '') as timestamp) as deleted_date,
    cast(max_attendees as int64) as max_attendees,
    cast(nullif(modified_date, '') as timestamp) as modified_date,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref("timeslots_ab1")}}
-- timeslots
where 1 = 1
