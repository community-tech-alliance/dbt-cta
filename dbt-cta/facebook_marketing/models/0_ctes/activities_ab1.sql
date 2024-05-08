
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'activities') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   actor_id,
   object_id,
   actor_name,
   event_time,
   event_type,
   extra_data,
   object_name,
   object_type,
   application_id,
   application_name,
   date_time_in_timezone,
   translated_event_type,
   {{ dbt_utils.surrogate_key([
     'actor_id',
    'object_id',
    'actor_name',
    'event_time',
    'event_type',
    'extra_data',
    'object_name',
    'object_type',
    'application_id',
    'application_name',
    'date_time_in_timezone',
    'translated_event_type'
    ]) }} as _airbyte_activities_hashid
from {{ source('cta', 'activities') }}