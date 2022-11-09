{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sla_policies_escalation_resolution_level4_ab1') }}
select
    _airbyte_resolution_hashid,
    cast(agent_ids as {{ dbt_utils.type_bigint() }}) as agent_ids,
    cast(escalation_time as {{ dbt_utils.type_bigint() }}) as escalation_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies_escalation_resolution_level4_ab1') }}
-- level4 at sla_policies/escalation/resolution/level4
where 1 = 1

