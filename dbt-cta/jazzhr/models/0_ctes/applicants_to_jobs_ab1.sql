{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_applicants_to_jobs') }}
select
    {{ json_extract_scalar('_airbyte_data', ['date'], ['date']) }} as date,
    {{ json_extract_scalar('_airbyte_data', ['applicant_id'], ['applicant_id']) }} as applicant_id,
    {{ json_extract_scalar('_airbyte_data', ['job_id'], ['job_id']) }} as job_id,
    {{ json_extract_scalar('_airbyte_data', ['rating'], ['rating']) }} as rating,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['workflow_step_id'], ['workflow_step_id']) }} as workflow_step_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_applicants_to_jobs') }} as table_alias
-- applicants_to_jobs
where 1 = 1

