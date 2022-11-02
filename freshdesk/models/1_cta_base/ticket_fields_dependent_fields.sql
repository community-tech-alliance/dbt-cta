{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('ticket_fields_dependent_fields_ab3') }}
select
    _airbyte_ticket_fields_hashid,
    id,
    name,
    label,
    level,
    created_at,
    updated_at,
    ticket_field_id,
    label_for_customers,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_dependent_fields_hashid
from {{ ref('ticket_fields_dependent_fields_ab3') }}
-- dependent_fields at ticket_fields/dependent_fields from {{ ref('ticket_fields') }}
where 1 = 1

