{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_jobs" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['zip'], ['zip']) }} as zip,
    {{ json_extract_scalar('_airbyte_data', ['maximum_salary'], ['maximum_salary']) }} as maximum_salary,
    {{ json_extract_scalar('_airbyte_data', ['questionnaire'], ['questionnaire']) }} as questionnaire,
    {{ json_extract_scalar('_airbyte_data', ['send_to_job_boards'], ['send_to_job_boards']) }} as send_to_job_boards,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['original_open_date'], ['original_open_date']) }} as original_open_date,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['board_code'], ['board_code']) }} as board_code,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['minimum_salary'], ['minimum_salary']) }} as minimum_salary,
    {{ json_extract_scalar('_airbyte_data', ['team_id'], ['team_id']) }} as team_id,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['hiring_lead'], ['hiring_lead']) }} as hiring_lead,
    {{ json_extract_scalar('_airbyte_data', ['internal_code'], ['internal_code']) }} as internal_code,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['department'], ['department']) }} as department,
    {{ json_extract_scalar('_airbyte_data', ['country_id'], ['country_id']) }} as country_id,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- jobs
where 1 = 1
