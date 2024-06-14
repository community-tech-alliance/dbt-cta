{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'oban_jobs') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    args,
    meta,
    tags,
    queue,
    state,
    errors,
    worker,
    attempt,
    priority,
    inserted_at,
    attempted_at,
    attempted_by,
    cancelled_at,
    completed_at,
    discarded_at,
    max_attempts,
    scheduled_at,
   {{ dbt_utils.surrogate_key([
     'id',
    'args',
    'meta',
    'queue',
    'state',
    'worker',
    'attempt',
    'priority',
    'max_attempts'
    ]) }} as _airbyte_oban_jobs_hashid
from {{ source('cta', 'oban_jobs') }}
