{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sla_policies_escalation_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_sla_policies_hashid',
        object_to_string('response'),
        object_to_string('resolution'),
    ]) }} as _airbyte_escalation_hashid,
    tmp.*
from {{ ref('sla_policies_escalation_ab2') }} tmp
-- escalation at sla_policies/escalation
where 1 = 1

