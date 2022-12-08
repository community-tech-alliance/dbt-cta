{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sla_policies_sla_target_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_sla_policies_hashid',
        object_to_string('priority_1'),
        object_to_string('priority_2'),
        object_to_string('priority_3'),
        object_to_string('priority_4'),
    ]) }} as _airbyte_sla_target_hashid,
    tmp.*
from {{ ref('sla_policies_sla_target_ab2') }} tmp
-- sla_target at sla_policies/sla_target
where 1 = 1

