{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_outcome_ab1') }}
select
    _airbyte_charges_hashid,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(reason as {{ dbt_utils.type_string() }}) as reason,
    cast(risk_level as {{ dbt_utils.type_string() }}) as risk_level,
    cast(risk_score as {{ dbt_utils.type_bigint() }}) as risk_score,
    cast(network_status as {{ dbt_utils.type_string() }}) as network_status,
    cast(seller_message as {{ dbt_utils.type_string() }}) as seller_message,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_outcome_ab1') }}
-- outcome at charges_base/outcome
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

