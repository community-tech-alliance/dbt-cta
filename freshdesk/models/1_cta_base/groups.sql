{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('groups_ab3') }}
select
    id,
    name,
    created_at,
    group_type,
    updated_at,
    description,
    escalate_to,
    unassigned_for,
    business_hour_id,
    auto_ticket_assign,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_groups_hashid
from {{ ref('groups_ab3') }}
-- groups from {{ source('freshdesk_partner_a', '_airbyte_raw_groups') }}
where 1 = 1

