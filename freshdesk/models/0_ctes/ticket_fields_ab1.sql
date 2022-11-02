{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('freshdesk_partner_a', '_airbyte_raw_ticket_fields') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['label'], ['label']) }} as label,
    {{ json_extract_scalar('_airbyte_data', ['is_fsm'], ['is_fsm']) }} as is_fsm,
    {{ json_extract_array('_airbyte_data', ['choices'], ['choices']) }} as choices,
    {{ json_extract_scalar('_airbyte_data', ['default'], ['default']) }} as {{ adapter.quote('default') }},
    {{ json_extract_scalar('_airbyte_data', ['position'], ['position']) }} as position,
    {{ json_extract_scalar('_airbyte_data', ['portal_cc'], ['portal_cc']) }} as portal_cc,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['portal_cc_to'], ['portal_cc_to']) }} as portal_cc_to,
    {{ json_extract('table_alias', '_airbyte_data', ['dependent_fields']) }} as dependent_fields,
    {{ json_extract_scalar('_airbyte_data', ['customers_can_edit'], ['customers_can_edit']) }} as customers_can_edit,
    {{ json_extract_scalar('_airbyte_data', ['label_for_customers'], ['label_for_customers']) }} as label_for_customers,
    {{ json_extract_scalar('_airbyte_data', ['required_for_agents'], ['required_for_agents']) }} as required_for_agents,
    {{ json_extract_scalar('_airbyte_data', ['required_for_closure'], ['required_for_closure']) }} as required_for_closure,
    {{ json_extract_scalar('_airbyte_data', ['displayed_to_customers'], ['displayed_to_customers']) }} as displayed_to_customers,
    {{ json_extract_scalar('_airbyte_data', ['required_for_customers'], ['required_for_customers']) }} as required_for_customers,
    {{ json_extract_scalar('_airbyte_data', ['field_update_in_progress'], ['field_update_in_progress']) }} as field_update_in_progress,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('freshdesk_partner_a', '_airbyte_raw_ticket_fields') }} as table_alias
-- ticket_fields
where 1 = 1

