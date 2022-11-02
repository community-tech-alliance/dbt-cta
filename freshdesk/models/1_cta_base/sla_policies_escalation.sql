{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('sla_policies_escalation_ab3') }}
select
    _airbyte_sla_policies_hashid,
    response,
    resolution,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_escalation_hashid
from {{ ref('sla_policies_escalation_ab3') }}
-- escalation at sla_policies/escalation from {{ ref('sla_policies') }}
where 1 = 1

