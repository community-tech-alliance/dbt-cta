{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('refunds_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(charge as {{ dbt_utils.type_string() }}) as charge,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(reason as {{ dbt_utils.type_string() }}) as reason,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(payment_intent as {{ dbt_utils.type_string() }}) as payment_intent,
    cast(receipt_number as {{ dbt_utils.type_string() }}) as receipt_number,
    cast(transfer_reversal as {{ dbt_utils.type_string() }}) as transfer_reversal,
    cast(balance_transaction as {{ dbt_utils.type_string() }}) as balance_transaction,
    cast(source_transfer_reversal as {{ dbt_utils.type_string() }}) as source_transfer_reversal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('refunds_ab1') }}
-- refunds
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

