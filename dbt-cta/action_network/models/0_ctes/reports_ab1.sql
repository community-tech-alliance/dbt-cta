{% set raw_table = env_var("CTA_DATASET_ID") ~ "_airbyte_raw_reports" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', 'raw_table') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['hidden'], ['hidden']) }} as hidden,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['start_date'], ['start_date']) }} as start_date,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_name'], ['csv_file_name']) }} as csv_file_name,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_size'], ['csv_file_size']) }} as csv_file_size,
    {{ json_extract_scalar('_airbyte_data', ['next_run_date'], ['next_run_date']) }} as next_run_date,
    {{ json_extract_scalar('_airbyte_data', ['report_format'], ['report_format']) }} as report_format,
    {{ json_extract_scalar('_airbyte_data', ['csv_updated_at'], ['csv_updated_at']) }} as csv_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['first_permalink'], ['first_permalink']) }} as first_permalink,
    {{ json_extract_scalar('_airbyte_data', ['csv_content_type'], ['csv_content_type']) }} as csv_content_type,
    {{ json_extract_scalar('_airbyte_data', ['recurring_emails'], ['recurring_emails']) }} as recurring_emails,
    {{ json_extract_scalar('_airbyte_data', ['recurring_interval'], ['recurring_interval']) }} as recurring_interval,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', 'raw_table') }}
-- reports
where 1 = 1
