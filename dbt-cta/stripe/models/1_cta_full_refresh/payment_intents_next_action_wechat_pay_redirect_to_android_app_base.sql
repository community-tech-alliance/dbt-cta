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
-- depends_on: {{ ref('payment_intents_next_action_wechat_pay_redirect_to_android_app_ab3') }}
select
    _airbyte_next_action_hashid,
    sign,
    app_id,
    package,
    nonce_str,
    prepay_id,
    timestamp,
    partner_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_wechat_pay_redirect_to_android_app_hashid
from {{ ref('payment_intents_next_action_wechat_pay_redirect_to_android_app_ab3') }}
-- wechat_pay_redirect_to_android_app at payment_intents_base/next_action/wechat_pay_redirect_to_android_app from {{ ref('payment_intents_next_action_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

