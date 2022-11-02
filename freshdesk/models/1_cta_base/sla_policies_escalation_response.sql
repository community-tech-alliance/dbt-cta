{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('sla_policies_escalation_response_ab3') }}
select
    _airbyte_escalation_hashid,
    agent_ids,
    escalation_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_response_hashid
from {{ ref('sla_policies_escalation_response_ab3') }}
-- response at sla_policies/escalation/response from {{ ref('sla_policies_escalation') }}
where 1 = 1

