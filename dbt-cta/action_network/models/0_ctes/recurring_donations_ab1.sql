{% set raw_table = env_var("CTA_DATASET_ID") ~ "_airbyte_raw_recurring_donations" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['values'], ['values']) }} as values,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['next_payment'], ['next_payment']) }} as next_payment,
    {{ json_extract_scalar('_airbyte_data', ['failure_count'], ['failure_count']) }} as failure_count,
    {{ json_extract_scalar('_airbyte_data', ['fundraising_id'], ['fundraising_id']) }} as fundraising_id,
    {{ json_extract_scalar('_airbyte_data', ['recurring_period'], ['recurring_period']) }} as recurring_period,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- recurring_donations
where 1 = 1
