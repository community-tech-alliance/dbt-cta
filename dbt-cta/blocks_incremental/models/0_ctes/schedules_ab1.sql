
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'schedules') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   day,
   date,
   rule,
   time,
   count,
   until,
   interval,
   created_at,
   updated_at,
   day_of_week,
   schedulable_id,
   schedulable_type,
   {{ dbt_utils.surrogate_key([
     'id',
    'day',
    'date',
    'rule',
    'count',
    'interval',
    'day_of_week',
    'schedulable_id',
    'schedulable_type'
    ]) }} as _airbyte_schedules_hashid
from {{ source('cta', 'schedules') }}