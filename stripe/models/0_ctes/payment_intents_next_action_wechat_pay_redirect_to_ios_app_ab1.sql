{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_next_action_base') }}
select
    _airbyte_next_action_hashid,
    {{ json_extract_scalar('wechat_pay_redirect_to_ios_app', ['native_url'], ['native_url']) }} as native_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_next_action_base') }} as table_alias
-- wechat_pay_redirect_to_ios_app at payment_intents_base/next_action/wechat_pay_redirect_to_ios_app
where 1 = 1
and wechat_pay_redirect_to_ios_app is not null
{{ incremental_clause('_airbyte_emitted_at') }}

