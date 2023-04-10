{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cards,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(address as {{ type_json() }}) as address,
    cast(balance as {{ dbt_utils.type_bigint() }}) as balance,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    sources,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(discount as {{ type_json() }}) as discount,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(shipping as {{ type_json() }}) as shipping,
    cast(tax_info as {{ dbt_utils.type_string() }}) as tax_info,
    {{ cast_to_boolean('delinquent') }} as delinquent,
    cast(tax_exempt as {{ dbt_utils.type_string() }}) as tax_exempt,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(default_card as {{ dbt_utils.type_string() }}) as default_card,
    cast(subscriptions as {{ type_json() }}) as subscriptions,
    cast(default_source as {{ dbt_utils.type_string() }}) as default_source,
    cast(invoice_prefix as {{ dbt_utils.type_string() }}) as invoice_prefix,
    cast(account_balance as {{ dbt_utils.type_bigint() }}) as account_balance,
    cast(invoice_settings as {{ type_json() }}) as invoice_settings,
    preferred_locales,
    cast(next_invoice_sequence as {{ dbt_utils.type_bigint() }}) as next_invoice_sequence,
    cast(tax_info_verification as {{ dbt_utils.type_string() }}) as tax_info_verification,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_ab1') }}
-- customers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

