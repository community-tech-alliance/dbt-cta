
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
   date,
   count,
   rule,
   created_at,
   schedulable_type,
   schedulable_id,
   updated_at,
   until,
   `interval`,
   id,
   time,
   day,
   day_of_week,
   {{ dbt_utils.surrogate_key([
     'date',
    'count',
    'rule',
    'schedulable_type',
    'schedulable_id',
    'id',
    'day',
    'day_of_week'
    ]) }} as _airbyte_schedules_hashid
from {{ source('cta', 'schedules') }}