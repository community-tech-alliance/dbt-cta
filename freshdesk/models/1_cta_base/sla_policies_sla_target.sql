{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('sla_policies_sla_target_ab3') }}
select
    _airbyte_sla_policies_hashid,
    priority_1,
    priority_2,
    priority_3,
    priority_4,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sla_target_hashid
from {{ ref('sla_policies_sla_target_ab3') }}
-- sla_target at sla_policies/sla_target from {{ ref('sla_policies') }}
where 1 = 1

