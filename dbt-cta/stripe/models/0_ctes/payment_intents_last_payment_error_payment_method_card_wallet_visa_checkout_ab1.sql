{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_base') }}
select
    _airbyte_wallet_hashid,
    {{ json_extract_scalar('visa_checkout', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('visa_checkout', ['email'], ['email']) }} as email,
    {{ json_extract('table_alias', 'visa_checkout', ['billing_address'], ['billing_address']) }} as billing_address,
    {{ json_extract('table_alias', 'visa_checkout', ['shipping_address'], ['shipping_address']) }} as shipping_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_base') }} as table_alias
-- visa_checkout at payment_intents_base/last_payment_error/payment_method/card/wallet/visa_checkout
where
    1 = 1
    and visa_checkout is not null
{{ incremental_clause('_airbyte_emitted_at') }}

