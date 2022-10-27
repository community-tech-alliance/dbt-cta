{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_next_action_ab1') }}
select
    _airbyte_payment_intents_hashid,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(use_stripe_sdk as {{ type_json() }}) as use_stripe_sdk,
    cast(redirect_to_url as {{ type_json() }}) as redirect_to_url,
    cast(oxxo_display_details as {{ type_json() }}) as oxxo_display_details,
    cast(alipay_handle_redirect as {{ type_json() }}) as alipay_handle_redirect,
    cast(boleto_display_details as {{ type_json() }}) as boleto_display_details,
    cast(verify_with_microdeposits as {{ type_json() }}) as verify_with_microdeposits,
    cast(wechat_pay_display_qr_code as {{ type_json() }}) as wechat_pay_display_qr_code,
    cast(wechat_pay_redirect_to_ios_app as {{ type_json() }}) as wechat_pay_redirect_to_ios_app,
    cast(wechat_pay_redirect_to_android_app as {{ type_json() }}) as wechat_pay_redirect_to_android_app,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_next_action_ab1') }}
-- next_action at payment_intents/next_action
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

