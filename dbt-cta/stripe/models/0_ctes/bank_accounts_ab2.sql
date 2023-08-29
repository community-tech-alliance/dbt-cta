{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('bank_accounts_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(last4 as {{ dbt_utils.type_string() }}) as last4,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(bank_name as {{ dbt_utils.type_string() }}) as bank_name,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    cast(routing_number as {{ dbt_utils.type_string() }}) as routing_number,
    cast(account_holder_name as {{ dbt_utils.type_string() }}) as account_holder_name,
    cast(account_holder_type as {{ dbt_utils.type_string() }}) as account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bank_accounts_ab1') }}
-- bank_accounts
where 1 = 1
