{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_next_action_wechat_pay_display_qr_code_ab3') }}
select
    _airbyte_next_action_hashid,
    data,
    image_data_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_wechat_pay_display_qr_code_hashid
from {{ ref('payment_intents_next_action_wechat_pay_display_qr_code_ab3') }}
-- wechat_pay_display_qr_code at payment_intents_base/next_action/wechat_pay_display_qr_code from {{ ref('payment_intents_next_action') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

