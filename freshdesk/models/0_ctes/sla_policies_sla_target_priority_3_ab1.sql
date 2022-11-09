{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sla_policies_sla_target') }}
select
    _airbyte_sla_target_hashid,
    {{ json_extract_scalar('priority_3', ['business_hours'], ['business_hours']) }} as business_hours,
    {{ json_extract_scalar('priority_3', ['resolve_within'], ['resolve_within']) }} as resolve_within,
    {{ json_extract_scalar('priority_3', ['respond_within'], ['respond_within']) }} as respond_within,
    {{ json_extract_scalar('priority_3', ['escalation_enabled'], ['escalation_enabled']) }} as escalation_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies_sla_target') }} as table_alias
-- priority_3 at sla_policies/sla_target/priority_3
where 1 = 1
and priority_3 is not null

