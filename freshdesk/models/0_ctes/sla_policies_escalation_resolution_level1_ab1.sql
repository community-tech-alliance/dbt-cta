{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sla_policies_escalation_resolution') }}
select
    _airbyte_resolution_hashid,
    {{ json_extract_scalar('level1', ['agent_ids'], ['agent_ids']) }} as agent_ids,
    {{ json_extract_scalar('level1', ['escalation_time'], ['escalation_time']) }} as escalation_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies_escalation_resolution') }} as table_alias
-- level1 at sla_policies/escalation/resolution/level1
where 1 = 1
and level1 is not null

