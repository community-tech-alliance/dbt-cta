{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_disputes') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['charge'], ['charge']) }} as charge,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['reason'], ['reason']) }} as reason,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract('table_alias', '_airbyte_data', ['evidence'], ['evidence']) }} as evidence,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract('table_alias', '_airbyte_data', ['evidence_details'], ['evidence_details']) }} as evidence_details,
    {{ json_extract_array('_airbyte_data', ['balance_transactions'], ['balance_transactions']) }} as balance_transactions,
    {{ json_extract_scalar('_airbyte_data', ['is_charge_refundable'], ['is_charge_refundable']) }} as is_charge_refundable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_disputes') }} as table_alias
-- disputes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

