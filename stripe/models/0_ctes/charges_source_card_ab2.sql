{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_source_card_ab1') }}
select
    _airbyte_source_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(brand as {{ dbt_utils.type_string() }}) as brand,
    cast(last4 as {{ dbt_utils.type_string() }}) as last4,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(funding as {{ dbt_utils.type_string() }}) as funding,
    cast(exp_year as {{ dbt_utils.type_bigint() }}) as exp_year,
    cast(cvc_check as {{ dbt_utils.type_string() }}) as cvc_check,
    cast(exp_month as {{ dbt_utils.type_bigint() }}) as exp_month,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    cast(dynamic_last4 as {{ dbt_utils.type_string() }}) as dynamic_last4,
    cast(three_d_secure as {{ dbt_utils.type_string() }}) as three_d_secure,
    cast(address_zip_check as {{ dbt_utils.type_string() }}) as address_zip_check,
    cast(address_line1_check as {{ dbt_utils.type_string() }}) as address_line1_check,
    cast(tokenization_method as {{ dbt_utils.type_string() }}) as tokenization_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source_card_ab1') }}
-- card at charges/source/card
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

