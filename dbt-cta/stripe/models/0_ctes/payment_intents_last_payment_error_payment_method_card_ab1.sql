{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_base') }}
select
    _airbyte_payment_method_hashid,
    {{ json_extract_scalar('card', ['brand'], ['brand']) }} as brand,
    {{ json_extract_scalar('card', ['last4'], ['last4']) }} as last4,
    {{ json_extract('table_alias', 'card', ['checks'], ['checks']) }} as checks,
    {{ json_extract('table_alias', 'card', ['wallet'], ['wallet']) }} as wallet,
    {{ json_extract_scalar('card', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('card', ['funding'], ['funding']) }} as funding,
    {{ json_extract_scalar('card', ['exp_year'], ['exp_year']) }} as exp_year,
    {{ json_extract('table_alias', 'card', ['networks'], ['networks']) }} as networks,
    {{ json_extract_scalar('card', ['exp_month'], ['exp_month']) }} as exp_month,
    {{ json_extract_scalar('card', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract('table_alias', 'card', ['generated_from'], ['generated_from']) }} as generated_from,
    {{ json_extract('table_alias', 'card', ['three_d_secure_usage'], ['three_d_secure_usage']) }} as three_d_secure_usage,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_base') }} as table_alias
-- card at payment_intents_base/last_payment_error/payment_method/card
where
    1 = 1
    and card is not null
{{ incremental_clause('_airbyte_emitted_at') }}

