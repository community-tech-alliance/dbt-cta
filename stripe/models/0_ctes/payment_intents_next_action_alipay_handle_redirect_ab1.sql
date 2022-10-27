{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_next_action') }}
select
    _airbyte_next_action_hashid,
    {{ json_extract_scalar('alipay_handle_redirect', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('alipay_handle_redirect', ['native_url'], ['native_url']) }} as native_url,
    {{ json_extract_scalar('alipay_handle_redirect', ['return_url'], ['return_url']) }} as return_url,
    {{ json_extract_scalar('alipay_handle_redirect', ['native_data'], ['native_data']) }} as native_data,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_next_action') }} as table_alias
-- alipay_handle_redirect at payment_intents/next_action/alipay_handle_redirect
where 1 = 1
and alipay_handle_redirect is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

