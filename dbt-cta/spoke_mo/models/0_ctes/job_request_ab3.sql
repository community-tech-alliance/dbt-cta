{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('job_request_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'job_type',
        'queue_name',
        'updated_at',
        'result_message',
        'payload',
        'organization_id',
        'created_at',
        boolean_to_string('assigned'),
        boolean_to_string('locks_queue'),
        'id',
        'campaign_id',
        'status',
    ]) }} as _airbyte_job_request_hashid,
    tmp.*
from {{ ref('job_request_ab2') }} as tmp
-- job_request
where 1 = 1
