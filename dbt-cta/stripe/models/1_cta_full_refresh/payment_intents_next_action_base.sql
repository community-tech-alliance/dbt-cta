{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace,
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_next_action_ab3') }}
select
    _airbyte_payment_intents_hashid,
    type,
    use_stripe_sdk,
    redirect_to_url,
    oxxo_display_details,
    alipay_handle_redirect,
    boleto_display_details,
    verify_with_microdeposits,
    wechat_pay_display_qr_code,
    wechat_pay_redirect_to_ios_app,
    wechat_pay_redirect_to_android_app,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_next_action_hashid
from {{ ref('payment_intents_next_action_ab3') }}
-- next_action at payment_intents_base/next_action from {{ ref('payment_intents_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

