{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_applicants_to_jobs" %}

{{ config(
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', '__raw__stream_applicants_to_jobs') }}
select
    {{ json_extract_scalar('_airbyte_data', ['date'], ['date']) }} as date,
    {{ json_extract_scalar('_airbyte_data', ['applicant_id'], ['applicant_id']) }} as applicant_id,
    {{ json_extract_scalar('_airbyte_data', ['job_id'], ['job_id']) }} as job_id,
    {{ json_extract_scalar('_airbyte_data', ['rating'], ['rating']) }} as rating,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['workflow_step_id'], ['workflow_step_id']) }} as workflow_step_id,
    airbyte_raw_id,
    airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', '_raw__stream_applicants_to_jobs') }} as table_alias
-- applicants_to_jobs
where 1 = 1

