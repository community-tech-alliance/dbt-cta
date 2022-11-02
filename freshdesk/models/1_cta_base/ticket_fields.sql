{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('ticket_fields_ab3') }}
select
    id,
    name,
    type,
    label,
    is_fsm,
    choices,
    {{ adapter.quote('default') }},
    position,
    portal_cc,
    created_at,
    updated_at,
    description,
    portal_cc_to,
    dependent_fields,
    customers_can_edit,
    label_for_customers,
    required_for_agents,
    required_for_closure,
    displayed_to_customers,
    required_for_customers,
    field_update_in_progress,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ticket_fields_hashid
from {{ ref('ticket_fields_ab3') }}
-- ticket_fields from {{ source('freshdesk_partner_a', '_airbyte_raw_ticket_fields') }}
where 1 = 1

