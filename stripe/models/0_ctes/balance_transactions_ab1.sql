{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_balance_transactions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['fee'], ['fee']) }} as fee,
    {{ json_extract_scalar('_airbyte_data', ['net'], ['net']) }} as net,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as source,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_array('_airbyte_data', ['fee_details'], ['fee_details']) }} as fee_details,
    {{ json_extract_scalar('_airbyte_data', ['available_on'], ['available_on']) }} as available_on,
    {{ json_extract_scalar('_airbyte_data', ['exchange_rate'], ['exchange_rate']) }} as exchange_rate,
    {{ json_extract_array('_airbyte_data', ['sourced_transfers'], ['sourced_transfers']) }} as sourced_transfers,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_balance_transactions') }} as table_alias
-- balance_transactions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

