{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_next_action_alipay_handle_redirect_ab3') }}
select
    _airbyte_next_action_hashid,
    url,
    native_url,
    return_url,
    native_data,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_alipay_handle_redirect_hashid
from {{ ref('payment_intents_next_action_alipay_handle_redirect_ab3') }}
-- alipay_handle_redirect at payment_intents/next_action/alipay_handle_redirect from {{ ref('payment_intents_next_action') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

