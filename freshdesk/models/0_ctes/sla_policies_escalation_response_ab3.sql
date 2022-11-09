{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sla_policies_escalation_response_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_escalation_hashid',
        'agent_ids',
        'escalation_time',
    ]) }} as _airbyte_response_hashid,
    tmp.*
from {{ ref('sla_policies_escalation_response_ab2') }} tmp
-- response at sla_policies/escalation/response
where 1 = 1

