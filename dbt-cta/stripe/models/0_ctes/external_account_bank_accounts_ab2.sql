{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('external_account_bank_accounts_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(last4 as {{ dbt_utils.type_string() }}) as last4,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(account as {{ dbt_utils.type_string() }}) as account,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(bank_name as {{ dbt_utils.type_string() }}) as bank_name,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    cast(account_type as {{ dbt_utils.type_string() }}) as account_type,
    cast(routing_number as {{ dbt_utils.type_string() }}) as routing_number,
    cast(account_holder_name as {{ dbt_utils.type_string() }}) as account_holder_name,
    cast(account_holder_type as {{ dbt_utils.type_string() }}) as account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('external_account_bank_accounts_ab1') }}
-- external_account_bank_accounts
where 1 = 1

