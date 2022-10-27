{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error') }}
select
    _airbyte_last_payment_error_hashid,
    {{ json_extract_scalar('payment_method', ['id'], ['id']) }} as id,
    {{ json_extract('table_alias', 'payment_method', ['eps'], ['eps']) }} as eps,
    {{ json_extract('table_alias', 'payment_method', ['fpx'], ['fpx']) }} as fpx,
    {{ json_extract('table_alias', 'payment_method', ['p24'], ['p24']) }} as p24,
    {{ json_extract('table_alias', 'payment_method', ['card'], ['card']) }} as card,
    {{ json_extract('table_alias', 'payment_method', ['oxxo'], ['oxxo']) }} as oxxo,
    {{ json_extract_scalar('payment_method', ['type'], ['type']) }} as type,
    {{ json_extract('table_alias', 'payment_method', ['ideal'], ['ideal']) }} as ideal,
    {{ json_extract_scalar('payment_method', ['alipay'], ['alipay']) }} as alipay,
    {{ json_extract('table_alias', 'payment_method', ['boleto'], ['boleto']) }} as boleto,
    {{ json_extract_scalar('payment_method', ['object'], ['object']) }} as object,
    {{ json_extract('table_alias', 'payment_method', ['sofort'], ['sofort']) }} as sofort,
    {{ json_extract_scalar('payment_method', ['created'], ['created']) }} as created,
    {{ json_extract('table_alias', 'payment_method', ['giropay'], ['giropay']) }} as giropay,
    {{ json_extract('table_alias', 'payment_method', ['grabpay'], ['grabpay']) }} as grabpay,
    {{ json_extract_scalar('payment_method', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('payment_method', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', 'payment_method', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract('table_alias', 'payment_method', ['acss_debit'], ['acss_debit']) }} as acss_debit,
    {{ json_extract('table_alias', 'payment_method', ['bacs_debit'], ['bacs_debit']) }} as bacs_debit,
    {{ json_extract_scalar('payment_method', ['bancontact'], ['bancontact']) }} as bancontact,
    {{ json_extract('table_alias', 'payment_method', ['sepa_debit'], ['sepa_debit']) }} as sepa_debit,
    {{ json_extract('table_alias', 'payment_method', ['wechat_pay'], ['wechat_pay']) }} as wechat_pay,
    {{ json_extract('table_alias', 'payment_method', ['card_present'], ['card_present']) }} as card_present,
    {{ json_extract('table_alias', 'payment_method', ['au_becs_debit'], ['au_becs_debit']) }} as au_becs_debit,
    {{ json_extract('table_alias', 'payment_method', ['billing_details'], ['billing_details']) }} as billing_details,
    {{ json_extract('table_alias', 'payment_method', ['interac_present'], ['interac_present']) }} as interac_present,
    {{ json_extract_scalar('payment_method', ['afterpay_clearpay'], ['afterpay_clearpay']) }} as afterpay_clearpay,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error') }} as table_alias
-- payment_method at payment_intents/last_payment_error/payment_method
where 1 = 1
and payment_method is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

