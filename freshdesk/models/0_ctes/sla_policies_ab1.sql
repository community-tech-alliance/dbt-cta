{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('freshdesk_partner_a', '_airbyte_raw_sla_policies') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['position'], ['position']) }} as position,
    {{ json_extract('table_alias', '_airbyte_data', ['escalation'], ['escalation']) }} as escalation,
    {{ json_extract_scalar('_airbyte_data', ['is_default'], ['is_default']) }} as is_default,
    {{ json_extract('table_alias', '_airbyte_data', ['sla_target'], ['sla_target']) }} as sla_target,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract('table_alias', '_airbyte_data', ['applicable_to'], ['applicable_to']) }} as applicable_to,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('freshdesk_partner_a', '_airbyte_raw_sla_policies') }} as table_alias
-- sla_policies
where 1 = 1

