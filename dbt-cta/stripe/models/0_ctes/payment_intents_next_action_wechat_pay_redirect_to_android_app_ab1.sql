{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_next_action_base') }}
select
    _airbyte_next_action_hashid,
    {{ json_extract_scalar('wechat_pay_redirect_to_android_app', ['sign'], ['sign']) }} as sign,
    {{ json_extract_scalar('wechat_pay_redirect_to_android_app', ['app_id'], ['app_id']) }} as app_id,
    {{ json_extract_scalar('wechat_pay_redirect_to_android_app', ['package'], ['package']) }} as package,
    {{ json_extract_scalar('wechat_pay_redirect_to_android_app', ['nonce_str'], ['nonce_str']) }} as nonce_str,
    {{ json_extract_scalar('wechat_pay_redirect_to_android_app', ['prepay_id'], ['prepay_id']) }} as prepay_id,
    {{ json_extract_scalar('wechat_pay_redirect_to_android_app', ['timestamp'], ['timestamp']) }} as timestamp,
    {{ json_extract_scalar('wechat_pay_redirect_to_android_app', ['partner_id'], ['partner_id']) }} as partner_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_next_action_base') }} as table_alias
-- wechat_pay_redirect_to_android_app at payment_intents_base/next_action/wechat_pay_redirect_to_android_app
where 1 = 1
and wechat_pay_redirect_to_android_app is not null
{{ incremental_clause('_airbyte_emitted_at') }}

