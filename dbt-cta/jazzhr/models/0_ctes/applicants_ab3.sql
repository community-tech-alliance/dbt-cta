{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('applicants_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'apply_date',
        'job_id',
        'last_name',
        'id',
        'job_title',
        'first_name',
        'prospect_phone',
    ]) }} as _airbyte_applicants_hashid,
    tmp.*
from {{ ref('applicants_ab2') }} tmp
-- applicants
where 1 = 1

