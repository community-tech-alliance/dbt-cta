{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_ab1') }}
select
    _airbyte_last_payment_error_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(eps as {{ type_json() }}) as eps,
    cast(fpx as {{ type_json() }}) as fpx,
    cast(p24 as {{ type_json() }}) as p24,
    cast(card as {{ type_json() }}) as card,
    cast(oxxo as {{ type_json() }}) as oxxo,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(ideal as {{ type_json() }}) as ideal,
    cast(alipay as {{ dbt_utils.type_string() }}) as alipay,
    cast(boleto as {{ type_json() }}) as boleto,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(sofort as {{ type_json() }}) as sofort,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(giropay as {{ type_json() }}) as giropay,
    cast(grabpay as {{ type_json() }}) as grabpay,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(acss_debit as {{ type_json() }}) as acss_debit,
    cast(bacs_debit as {{ type_json() }}) as bacs_debit,
    cast(bancontact as {{ dbt_utils.type_string() }}) as bancontact,
    cast(sepa_debit as {{ type_json() }}) as sepa_debit,
    cast(wechat_pay as {{ type_json() }}) as wechat_pay,
    cast(card_present as {{ type_json() }}) as card_present,
    cast(au_becs_debit as {{ type_json() }}) as au_becs_debit,
    cast(billing_details as {{ type_json() }}) as billing_details,
    cast(interac_present as {{ type_json() }}) as interac_present,
    cast(afterpay_clearpay as {{ dbt_utils.type_string() }}) as afterpay_clearpay,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_ab1') }}
-- payment_method at payment_intents_base/last_payment_error/payment_method
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

