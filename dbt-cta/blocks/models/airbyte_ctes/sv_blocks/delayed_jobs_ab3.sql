{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('delayed_jobs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'handler',
        'locked_by',
        'updated_at',
        'locked_at',
        'created_at',
        'id',
        'run_at',
        'failed_at',
        'last_error',
        'priority',
        'queue',
        'attempts',
    ]) }} as _airbyte_delayed_jobs_hashid,
    tmp.*
from {{ ref('delayed_jobs_ab2') }} tmp
-- delayed_jobs
where 1 = 1

