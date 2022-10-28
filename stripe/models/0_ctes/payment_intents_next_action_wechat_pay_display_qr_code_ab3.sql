{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_next_action_wechat_pay_display_qr_code_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_next_action_hashid',
        'data',
        'image_data_url',
    ]) }} as _airbyte_wechat_pay_display_qr_code_hashid,
    tmp.*
from {{ ref('payment_intents_next_action_wechat_pay_display_qr_code_ab2') }} tmp
-- wechat_pay_display_qr_code at payment_intents/next_action/wechat_pay_display_qr_code
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

