{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_transfers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['date'], ['date']) }} as date,
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['reversed'], ['reversed']) }} as reversed,
    {{ json_extract_scalar('_airbyte_data', ['automatic'], ['automatic']) }} as automatic,
    {{ json_extract_scalar('_airbyte_data', ['recipient'], ['recipient']) }} as recipient,
    {{ json_extract('table_alias', '_airbyte_data', ['reversals'], ['reversals']) }} as reversals,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['destination'], ['destination']) }} as destination,
    {{ json_extract_scalar('_airbyte_data', ['source_type'], ['source_type']) }} as source_type,
    {{ json_extract_scalar('_airbyte_data', ['arrival_date'], ['arrival_date']) }} as arrival_date,
    {{ json_extract_scalar('_airbyte_data', ['transfer_group'], ['transfer_group']) }} as transfer_group,
    {{ json_extract_scalar('_airbyte_data', ['amount_reversed'], ['amount_reversed']) }} as amount_reversed,
    {{ json_extract_scalar('_airbyte_data', ['source_transaction'], ['source_transaction']) }} as source_transaction,
    {{ json_extract_scalar('_airbyte_data', ['balance_transaction'], ['balance_transaction']) }} as balance_transaction,
    {{ json_extract_scalar('_airbyte_data', ['statement_descriptor'], ['statement_descriptor']) }} as statement_descriptor,
    {{ json_extract_scalar('_airbyte_data', ['statement_description'], ['statement_description']) }} as statement_description,
    {{ json_extract_scalar('_airbyte_data', ['failure_balance_transaction'], ['failure_balance_transaction']) }} as failure_balance_transaction,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_transfers') }} as table_alias
-- transfers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

