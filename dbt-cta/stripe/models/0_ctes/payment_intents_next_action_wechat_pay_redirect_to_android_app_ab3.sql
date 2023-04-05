{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_next_action_wechat_pay_redirect_to_android_app_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_next_action_hashid',
        'sign',
        'app_id',
        'package',
        'nonce_str',
        'prepay_id',
        'timestamp',
        'partner_id',
    ]) }} as _airbyte_wechat_pay_redirect_to_android_app_hashid,
    tmp.*
from {{ ref('payment_intents_next_action_wechat_pay_redirect_to_android_app_ab2') }} tmp
-- wechat_pay_redirect_to_android_app at payment_intents_base/next_action/wechat_pay_redirect_to_android_app
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

