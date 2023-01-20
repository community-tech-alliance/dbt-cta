{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('job_request_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'status',
        'payload',
        boolean_to_string('assigned'),
        'job_type',
        'created_at',
        'queue_name',
        'updated_at',
        'campaign_id',
        boolean_to_string('locks_queue'),
        'result_message',
    ]) }} as _airbyte_job_request_hashid,
    tmp.*
from {{ ref('job_request_ab2') }} tmp
-- job_request
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

