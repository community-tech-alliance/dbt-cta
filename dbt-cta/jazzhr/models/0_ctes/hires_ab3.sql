{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('hires_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'hired_time',
        'applicant_id',
        'job_id',
        'id',
        'workflow_step_id',
        'workflow_step_name',
        'hired_date',
    ]) }} as _airbyte_hires_hashid,
    tmp.*
from {{ ref('hires_ab2') }} tmp
-- hires
where 1 = 1

