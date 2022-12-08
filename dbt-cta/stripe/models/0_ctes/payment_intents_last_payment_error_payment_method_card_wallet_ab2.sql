{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_ab1') }}
select
    _airbyte_card_hashid,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(apple_pay as {{ dbt_utils.type_string() }}) as apple_pay,
    cast(google_pay as {{ dbt_utils.type_string() }}) as google_pay,
    cast(masterpass as {{ type_json() }}) as masterpass,
    cast(samsung_pay as {{ dbt_utils.type_string() }}) as samsung_pay,
    cast(dynamic_last4 as {{ dbt_utils.type_string() }}) as dynamic_last4,
    cast(visa_checkout as {{ type_json() }}) as visa_checkout,
    cast(amex_express_checkout as {{ dbt_utils.type_string() }}) as amex_express_checkout,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_ab1') }}
-- wallet at payment_intents_base/last_payment_error/payment_method/card/wallet
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

