{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('sla_policies_sla_target_priority_2_ab3') }}
select
    _airbyte_sla_target_hashid,
    business_hours,
    resolve_within,
    respond_within,
    escalation_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_priority_2_hashid
from {{ ref('sla_policies_sla_target_priority_2_ab3') }}
-- priority_2 at sla_policies/sla_target/priority_2 from {{ ref('sla_policies_sla_target') }}
where 1 = 1

