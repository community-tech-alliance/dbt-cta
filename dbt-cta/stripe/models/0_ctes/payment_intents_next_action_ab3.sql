{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_next_action_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_payment_intents_hashid',
        'type',
        object_to_string('use_stripe_sdk'),
        object_to_string('redirect_to_url'),
        object_to_string('oxxo_display_details'),
        object_to_string('alipay_handle_redirect'),
        object_to_string('boleto_display_details'),
        object_to_string('verify_with_microdeposits'),
        object_to_string('wechat_pay_display_qr_code'),
        object_to_string('wechat_pay_redirect_to_ios_app'),
        object_to_string('wechat_pay_redirect_to_android_app'),
    ]) }} as _airbyte_next_action_hashid,
    tmp.*
from {{ ref('payment_intents_next_action_ab2') }} as tmp
-- next_action at payment_intents_base/next_action
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

