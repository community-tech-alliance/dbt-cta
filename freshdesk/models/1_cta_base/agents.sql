{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('agents_ab3') }}
select
    id,
    type,
    contact,
    available,
    signature,
    created_at,
    occasional,
    updated_at,
    ticket_scope,
    last_active_at,
    available_since,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_agents_hashid
from {{ ref('agents_ab3') }}
-- agents from {{ source('freshdesk_partner_a', '_airbyte_raw_agents') }}
where 1 = 1

