{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sla_policies_escalation_resolution_ab1') }}
select
    _airbyte_escalation_hashid,
    cast(level1 as {{ type_json() }}) as level1,
    cast(level2 as {{ type_json() }}) as level2,
    cast(level3 as {{ type_json() }}) as level3,
    cast(level4 as {{ type_json() }}) as level4,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies_escalation_resolution_ab1') }}
-- resolution at sla_policies/escalation/resolution
where 1 = 1

