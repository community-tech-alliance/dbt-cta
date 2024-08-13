{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('external_account_cards_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(brand as {{ dbt_utils.type_string() }}) as brand,
    cast(last4 as {{ dbt_utils.type_string() }}) as last4,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(account as {{ dbt_utils.type_string() }}) as account,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(funding as {{ dbt_utils.type_string() }}) as funding,
    cast(exp_year as {{ dbt_utils.type_bigint() }}) as exp_year,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(cvc_check as {{ dbt_utils.type_string() }}) as cvc_check,
    cast(exp_month as {{ dbt_utils.type_bigint() }}) as exp_month,
    cast(redaction as {{ dbt_utils.type_string() }}) as redaction,
    cast(address_zip as {{ dbt_utils.type_string() }}) as address_zip,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    cast(address_city as {{ dbt_utils.type_string() }}) as address_city,
    cast(address_line1 as {{ dbt_utils.type_string() }}) as address_line1,
    cast(address_line2 as {{ dbt_utils.type_string() }}) as address_line2,
    cast(address_state as {{ dbt_utils.type_string() }}) as address_state,
    cast(dynamic_last4 as {{ dbt_utils.type_string() }}) as dynamic_last4,
    cast(address_country as {{ dbt_utils.type_string() }}) as address_country,
    cast(address_zip_check as {{ dbt_utils.type_string() }}) as address_zip_check,
    cast(address_line1_check as {{ dbt_utils.type_string() }}) as address_line1_check,
    cast(tokenization_method as {{ dbt_utils.type_string() }}) as tokenization_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('external_account_cards_ab1') }}
-- external_account_cards
where 1 = 1
