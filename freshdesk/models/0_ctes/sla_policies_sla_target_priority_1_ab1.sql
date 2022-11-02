{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sla_policies_sla_target') }}
select
    _airbyte_sla_target_hashid,
    {{ json_extract_scalar('priority_1', ['business_hours'], ['business_hours']) }} as business_hours,
    {{ json_extract_scalar('priority_1', ['resolve_within'], ['resolve_within']) }} as resolve_within,
    {{ json_extract_scalar('priority_1', ['respond_within'], ['respond_within']) }} as respond_within,
    {{ json_extract_scalar('priority_1', ['escalation_enabled'], ['escalation_enabled']) }} as escalation_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies_sla_target') }} as table_alias
-- priority_1 at sla_policies/sla_target/priority_1
where 1 = 1
and priority_1 is not null

