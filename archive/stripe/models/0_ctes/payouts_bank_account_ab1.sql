{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payouts_base') }}
select
    _airbyte_payouts_hashid,
    {{ json_extract_scalar('bank_account', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('bank_account', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('bank_account', ['last4'], ['last4']) }} as last4,
    {{ json_extract_scalar('bank_account', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('bank_account', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('bank_account', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('bank_account', ['currency'], ['currency']) }} as currency,
    {{ json_extract('table_alias', 'bank_account', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('bank_account', ['bank_name'], ['bank_name']) }} as bank_name,
    {{ json_extract_scalar('bank_account', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract_scalar('bank_account', ['routing_number'], ['routing_number']) }} as routing_number,
    {{ json_extract_scalar('bank_account', ['account_holder_name'], ['account_holder_name']) }} as account_holder_name,
    {{ json_extract_scalar('bank_account', ['account_holder_type'], ['account_holder_type']) }} as account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payouts_base') }} as table_alias
-- bank_account at payouts_base/bank_account
where
    1 = 1
    and bank_account is not null
{{ incremental_clause('_airbyte_emitted_at') }}

