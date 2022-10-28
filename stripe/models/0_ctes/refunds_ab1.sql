{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('stripe_partner_a', '_airbyte_raw_refunds') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['charge'], ['charge']) }} as charge,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['reason'], ['reason']) }} as reason,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['payment_intent'], ['payment_intent']) }} as payment_intent,
    {{ json_extract_scalar('_airbyte_data', ['receipt_number'], ['receipt_number']) }} as receipt_number,
    {{ json_extract_scalar('_airbyte_data', ['transfer_reversal'], ['transfer_reversal']) }} as transfer_reversal,
    {{ json_extract_scalar('_airbyte_data', ['balance_transaction'], ['balance_transaction']) }} as balance_transaction,
    {{ json_extract_scalar('_airbyte_data', ['source_transfer_reversal'], ['source_transfer_reversal']) }} as source_transfer_reversal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('stripe_partner_a', '_airbyte_raw_refunds') }} as table_alias
-- refunds
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

