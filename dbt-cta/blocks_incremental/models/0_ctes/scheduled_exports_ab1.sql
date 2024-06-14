{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'scheduled_exports') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    uuid,
    format,
    paused,
    columns,
    user_id,
    frequency,
    created_at,
    recipients,
    table_name,
    updated_at,
    attachment_name,
    day_of_the_week,
    hour_of_the_day,
    last_processed_at,
    time_zone_identifier,
   {{ dbt_utils.surrogate_key([
     'id',
    'uuid',
    'format',
    'paused',
    'columns',
    'user_id',
    'frequency',
    'recipients',
    'table_name',
    'attachment_name',
    'day_of_the_week',
    'hour_of_the_day',
    'time_zone_identifier'
    ]) }} as _airbyte_scheduled_exports_hashid
from {{ source('cta', 'scheduled_exports') }}
