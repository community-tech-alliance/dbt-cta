
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'delayed_jobs') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   handler,
   locked_by,
   updated_at,
   locked_at,
   created_at,
   id,
   run_at,
   failed_at,
   last_error,
   priority,
   queue,
   attempts,
   {{ dbt_utils.surrogate_key([
     'handler',
    'locked_by',
    'id',
    'last_error',
    'priority',
    'queue',
    'attempts'
    ]) }} as _airbyte_delayed_jobs_hashid
from {{ source('cta', 'delayed_jobs') }}