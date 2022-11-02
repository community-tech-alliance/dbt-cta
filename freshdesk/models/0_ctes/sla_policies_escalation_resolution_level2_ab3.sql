{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sla_policies_escalation_resolution_level2_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_resolution_hashid',
        'agent_ids',
        'escalation_time',
    ]) }} as _airbyte_level2_hashid,
    tmp.*
from {{ ref('sla_policies_escalation_resolution_level2_ab2') }} tmp
-- level2 at sla_policies/escalation/resolution/level2
where 1 = 1

