{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('disputes_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(charge as {{ dbt_utils.type_string() }}) as charge,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(reason as {{ dbt_utils.type_string() }}) as reason,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(evidence as {{ type_json() }}) as evidence,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(evidence_details as {{ type_json() }}) as evidence_details,
    balance_transactions,
    {{ cast_to_boolean('is_charge_refundable') }} as is_charge_refundable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('disputes_ab1') }}
-- disputes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

