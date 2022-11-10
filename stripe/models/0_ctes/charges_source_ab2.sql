{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_source_ab1') }}
select
    _airbyte_charges_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(eps as {{ type_json() }}) as eps,
    cast(card as {{ type_json() }}) as card,
    cast(flow as {{ dbt_utils.type_string() }}) as flow,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(brand as {{ dbt_utils.type_string() }}) as brand,
    cast(ideal as {{ type_json() }}) as ideal,
    cast(last4 as {{ dbt_utils.type_string() }}) as last4,
    cast(owner as {{ type_json() }}) as owner,
    cast(usage as {{ dbt_utils.type_string() }}) as usage,
    cast(alipay as {{ type_json() }}) as alipay,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(funding as {{ dbt_utils.type_string() }}) as funding,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    cast(exp_year as {{ dbt_utils.type_bigint() }}) as exp_year,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(receiver as {{ type_json() }}) as receiver,
    cast(redirect as {{ type_json() }}) as redirect,
    cast(cvc_check as {{ dbt_utils.type_string() }}) as cvc_check,
    cast(exp_month as {{ dbt_utils.type_bigint() }}) as exp_month,
    cast(bancontact as {{ type_json() }}) as bancontact,
    cast(multibanco as {{ type_json() }}) as multibanco,
    cast(address_zip as {{ dbt_utils.type_string() }}) as address_zip,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    cast(address_city as {{ dbt_utils.type_string() }}) as address_city,
    cast(address_line1 as {{ dbt_utils.type_string() }}) as address_line1,
    cast(address_line2 as {{ dbt_utils.type_string() }}) as address_line2,
    cast(address_state as {{ dbt_utils.type_string() }}) as address_state,
    cast(client_secret as {{ dbt_utils.type_string() }}) as client_secret,
    cast(dynamic_last4 as {{ dbt_utils.type_string() }}) as dynamic_last4,
    cast(address_country as {{ dbt_utils.type_string() }}) as address_country,
    cast(address_zip_check as {{ dbt_utils.type_string() }}) as address_zip_check,
    cast(ach_credit_transfer as {{ type_json() }}) as ach_credit_transfer,
    cast(address_line1_check as {{ dbt_utils.type_string() }}) as address_line1_check,
    cast(tokenization_method as {{ dbt_utils.type_string() }}) as tokenization_method,
    cast(statement_descriptor as {{ dbt_utils.type_string() }}) as statement_descriptor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source_ab1') }}
-- source at charges_base/source
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

