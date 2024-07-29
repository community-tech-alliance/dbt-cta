{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('applicants_to_jobs_ab1') }}
select
    cast(date as {{ dbt_utils.type_string() }}) as date,
    cast(applicant_id as {{ dbt_utils.type_string() }}) as applicant_id,
    cast(job_id as {{ dbt_utils.type_string() }}) as job_id,
    cast(rating as {{ dbt_utils.type_bigint() }}) as rating,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(workflow_step_id as {{ dbt_utils.type_bigint() }}) as workflow_step_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('applicants_to_jobs_ab1') }}
-- applicants_to_jobs
where 1 = 1

