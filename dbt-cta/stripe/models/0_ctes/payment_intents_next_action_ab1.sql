{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_base') }}
select
    _airbyte_payment_intents_hashid,
    {{ json_extract_scalar('next_action', ['type'], ['type']) }} as type,
    {{ json_extract('table_alias', 'next_action', ['use_stripe_sdk'], ['use_stripe_sdk']) }} as use_stripe_sdk,
    {{ json_extract('table_alias', 'next_action', ['redirect_to_url'], ['redirect_to_url']) }} as redirect_to_url,
    {{ json_extract('table_alias', 'next_action', ['oxxo_display_details'], ['oxxo_display_details']) }} as oxxo_display_details,
    {{ json_extract('table_alias', 'next_action', ['alipay_handle_redirect'], ['alipay_handle_redirect']) }} as alipay_handle_redirect,
    {{ json_extract('table_alias', 'next_action', ['boleto_display_details'], ['boleto_display_details']) }} as boleto_display_details,
    {{ json_extract('table_alias', 'next_action', ['verify_with_microdeposits'], ['verify_with_microdeposits']) }} as verify_with_microdeposits,
    {{ json_extract('table_alias', 'next_action', ['wechat_pay_display_qr_code'], ['wechat_pay_display_qr_code']) }} as wechat_pay_display_qr_code,
    {{ json_extract('table_alias', 'next_action', ['wechat_pay_redirect_to_ios_app'], ['wechat_pay_redirect_to_ios_app']) }} as wechat_pay_redirect_to_ios_app,
    {{ json_extract('table_alias', 'next_action', ['wechat_pay_redirect_to_android_app'], ['wechat_pay_redirect_to_android_app']) }} as wechat_pay_redirect_to_android_app,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_base') }} as table_alias
-- next_action at payment_intents_base/next_action
where
    1 = 1
    and next_action is not null
{{ incremental_clause('_airbyte_emitted_at') }}

