{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('applicants_to_jobs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'date',
        'applicant_id',
        'job_id',
        'rating',
        'id',
        'workflow_step_id',
    ]) }} as _airbyte_applicants_to_jobs_hashid,
    tmp.*
from {{ ref('applicants_to_jobs_ab2') }} tmp
-- applicants_to_jobs
where 1 = 1

