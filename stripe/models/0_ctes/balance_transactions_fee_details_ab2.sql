{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('balance_transactions_fee_details_ab1') }}
select
    _airbyte_balance_transactions_hashid,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(application as {{ dbt_utils.type_string() }}) as application,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('balance_transactions_fee_details_ab1') }}
-- fee_details at balance_transactions/fee_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

