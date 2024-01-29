{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sla_policy_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'name',
        boolean_to_string('active'),
        'position',
        object_to_string('escalation'),
        boolean_to_string('is_default'),
        object_to_string('sla_target'),
        'description',
        object_to_string('applicable_to'),
    ]) }} as _airbyte_sla_policies_hashid,
    tmp.*
from {{ ref('sla_policy_ab2') }} tmp
-- sla_policies
where 1 = 1

