{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_donation_payments') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['tip'], ['tip']) }} as tip,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['error'], ['error']) }} as error,
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['wepay_id'], ['wepay_id']) }} as wepay_id,
    {{ json_extract_scalar('_airbyte_data', ['recurring'], ['recurring']) }} as recurring,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['error_code'], ['error_code']) }} as error_code,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['donation_id'], ['donation_id']) }} as donation_id,
    {{ json_extract_scalar('_airbyte_data', ['wepay_status'], ['wepay_status']) }} as wepay_status,
    {{ json_extract_scalar('_airbyte_data', ['error_message'], ['error_message']) }} as error_message,
    {{ json_extract_scalar('_airbyte_data', ['fundraising_id'], ['fundraising_id']) }} as fundraising_id,
    {{ json_extract_scalar('_airbyte_data', ['transaction_id'], ['transaction_id']) }} as transaction_id,
    {{ json_extract_scalar('_airbyte_data', ['donation_user_id'], ['donation_user_id']) }} as donation_user_id,
    {{ json_extract_scalar('_airbyte_data', ['recurring_period'], ['recurring_period']) }} as recurring_period,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_donation_payments') }}
-- donation_payments
where 1 = 1
