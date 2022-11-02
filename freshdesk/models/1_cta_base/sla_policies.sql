{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('sla_policies_ab3') }}
select
    id,
    name,
    active,
    position,
    escalation,
    is_default,
    sla_target,
    description,
    applicable_to,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sla_policies_hashid
from {{ ref('sla_policies_ab3') }}
-- sla_policies from {{ source('freshdesk_partner_a', '_airbyte_raw_sla_policies') }}
where 1 = 1

