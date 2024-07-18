{{ config(
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('jobs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'zip',
        'maximum_salary',
        'questionnaire',
        'send_to_job_boards',
        'notes',
        'original_open_date',
        'city',
        'board_code',
        'description',
        'minimum_salary',
        'team_id',
        'type',
        'title',
        'hiring_lead',
        'internal_code',
        'id',
        'state',
        'department',
        'country_id',
        'status',
    ]) }} as _airbyte_jobs_hashid,
    tmp.*
from {{ ref('jobs_ab2') }} tmp
-- jobs
where 1 = 1

