{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('ticket_field_ab3') }}
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
from {{ ref('ticket_field_ab3') }}
-- ticket_fields from {{ source('cta', '_airbyte_raw_ticket_fields') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
