{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_payments') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['note'], ['note']) }} as note,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['order_id'], ['order_id']) }} as order_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_string_array('_airbyte_data', ['refund_ids'], ['refund_ids']) }} as refund_ids,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['employee_id'], ['employee_id']) }} as employee_id,
    {{ json_extract_scalar('_airbyte_data', ['location_id'], ['location_id']) }} as location_id,
    {{ json_extract_scalar('_airbyte_data', ['receipt_url'], ['receipt_url']) }} as receipt_url,
    {{ json_extract_scalar('_airbyte_data', ['source_type'], ['source_type']) }} as source_type,
    {{ json_extract('table_alias', '_airbyte_data', ['total_money'], ['total_money']) }} as total_money,
    {{ json_extract('table_alias', '_airbyte_data', ['amount_money'], ['amount_money']) }} as amount_money,
    {{ json_extract('table_alias', '_airbyte_data', ['card_details'], ['card_details']) }} as card_details,
    {{ json_extract_scalar('_airbyte_data', ['delay_action'], ['delay_action']) }} as delay_action,
    {{ json_extract_scalar('_airbyte_data', ['delayed_until'], ['delayed_until']) }} as delayed_until,
    {{ json_extract_scalar('_airbyte_data', ['version_token'], ['version_token']) }} as version_token,
    {{ json_extract('table_alias', '_airbyte_data', ['approved_money'], ['approved_money']) }} as approved_money,
    {{ json_extract_scalar('_airbyte_data', ['delay_duration'], ['delay_duration']) }} as delay_duration,
    {{ json_extract_array('_airbyte_data', ['processing_fee'], ['processing_fee']) }} as processing_fee,
    {{ json_extract_scalar('_airbyte_data', ['receipt_number'], ['receipt_number']) }} as receipt_number,
    {{ json_extract('table_alias', '_airbyte_data', ['refunded_money'], ['refunded_money']) }} as refunded_money,
    {{ json_extract('table_alias', '_airbyte_data', ['risk_evaluation'], ['risk_evaluation']) }} as risk_evaluation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_payments') }} as table_alias
-- payments
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

