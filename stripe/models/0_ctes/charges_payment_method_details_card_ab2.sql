{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_payment_method_details_card_ab1') }}
select
    _airbyte_payment_method_details_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(eps as {{ type_json() }}) as eps,
    cast(p24 as {{ type_json() }}) as p24,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(brand as {{ dbt_utils.type_string() }}) as brand,
    cast(ideal as {{ type_json() }}) as ideal,
    cast(last4 as {{ dbt_utils.type_string() }}) as last4,
    cast(checks as {{ type_json() }}) as checks,
    cast(klarna as {{ type_json() }}) as klarna,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(sofort as {{ type_json() }}) as sofort,
    cast(wallet as {{ type_json() }}) as wallet,
    cast(wechat as {{ type_json() }}) as wechat,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(funding as {{ dbt_utils.type_string() }}) as funding,
    cast(giropay as {{ type_json() }}) as giropay,
    cast(network as {{ dbt_utils.type_string() }}) as network,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    cast(exp_year as {{ dbt_utils.type_bigint() }}) as exp_year,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(cvc_check as {{ dbt_utils.type_string() }}) as cvc_check,
    cast(exp_month as {{ dbt_utils.type_bigint() }}) as exp_month,
    cast(multibanco as {{ type_json() }}) as multibanco,
    cast(sepa_debit as {{ type_json() }}) as sepa_debit,
    cast(address_zip as {{ dbt_utils.type_string() }}) as address_zip,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    cast(address_city as {{ dbt_utils.type_string() }}) as address_city,
    cast(card_present as {{ type_json() }}) as card_present,
    cast(installments as {{ type_json() }}) as installments,
    cast(address_line1 as {{ dbt_utils.type_string() }}) as address_line1,
    cast(address_line2 as {{ dbt_utils.type_string() }}) as address_line2,
    cast(address_state as {{ dbt_utils.type_string() }}) as address_state,
    cast(dynamic_last4 as {{ dbt_utils.type_string() }}) as dynamic_last4,
    cast(stripe_account as {{ type_json() }}) as stripe_account,
    cast(three_d_secure as {{ type_json() }}) as three_d_secure,
    cast(address_country as {{ dbt_utils.type_string() }}) as address_country,
    cast(address_zip_check as {{ dbt_utils.type_string() }}) as address_zip_check,
    cast(address_line1_check as {{ dbt_utils.type_string() }}) as address_line1_check,
    cast(tokenization_method as {{ dbt_utils.type_string() }}) as tokenization_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card_ab1') }}
-- card at charges_base/payment_method_details/card
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

