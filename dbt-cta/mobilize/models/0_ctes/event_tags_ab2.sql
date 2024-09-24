{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}

-- SQL model to cast each column to its adequate SQL type converted from the JSON
-- schema type
-- depends_on: {{ ref("event_tags_ab1") }}
select
    cast(id as int64) as id,
    cast(tag_id as int64) as tag_id,
    cast(event_id as int64) as event_id,
    cast(tag__name as string) as tag__name,
    cast(nullif(created_date, '') as timestamp) as created_date,
    cast(nullif(deleted_date, '') as timestamp) as deleted_date,
    cast(nullif(modified_date, '') as timestamp) as modified_date,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ ref("event_tags_ab1") }}
-- event_tags
where 1 = 1
