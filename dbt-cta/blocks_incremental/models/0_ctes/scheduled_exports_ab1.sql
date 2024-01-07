
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
   day_of_the_week,
   paused,
   columns,
   attachment_name,
   format,
   created_at,
   uuid,
   table_name,
   frequency,
   updated_at,
   user_id,
   time_zone_identifier,
   recipients,
   last_processed_at,
   id,
   hour_of_the_day,
   {{ dbt_utils.surrogate_key([
     'day_of_the_week',
    'paused',
    'columns',
    'attachment_name',
    'format',
    'uuid',
    'table_name',
    'frequency',
    'user_id',
    'time_zone_identifier',
    'recipients',
    'id',
    'hour_of_the_day'
    ]) }} as _airbyte_scheduled_exports_hashid
from {{ source('cta', 'scheduled_exports') }}