{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_masterpass_base') }}
select
    _airbyte_masterpass_hashid,
    {{ json_extract_scalar('shipping_address', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('shipping_address', ['line1'], ['line1']) }} as line1,
    {{ json_extract_scalar('shipping_address', ['line2'], ['line2']) }} as line2,
    {{ json_extract_scalar('shipping_address', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('shipping_address', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('shipping_address', ['postal_code'], ['postal_code']) }} as postal_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_masterpass_base') }} as table_alias
-- shipping_address at payment_intents_base/last_payment_error/payment_method/card/wallet/masterpass/shipping_address
where 1 = 1
and shipping_address is not null
{{ incremental_clause('_airbyte_emitted_at') }}

