{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('disputes_balance_transactions_ab1') }}
select
    _airbyte_disputes_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('disputes_balance_transactions_ab1') }}
-- balance_transactions at disputes_base/balance_transactions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

