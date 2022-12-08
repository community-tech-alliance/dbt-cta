{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sla_policies_escalation_resolution_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_escalation_hashid',
        object_to_string('level1'),
        object_to_string('level2'),
        object_to_string('level3'),
        object_to_string('level4'),
    ]) }} as _airbyte_resolution_hashid,
    tmp.*
from {{ ref('sla_policies_escalation_resolution_ab2') }} tmp
-- resolution at sla_policies/escalation/resolution
where 1 = 1

