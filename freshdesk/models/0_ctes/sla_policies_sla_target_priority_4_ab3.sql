{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sla_policies_sla_target_priority_4_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_sla_target_hashid',
        boolean_to_string('business_hours'),
        'resolve_within',
        'respond_within',
        boolean_to_string('escalation_enabled'),
    ]) }} as _airbyte_priority_4_hashid,
    tmp.*
from {{ ref('sla_policies_sla_target_priority_4_ab2') }} tmp
-- priority_4 at sla_policies/sla_target/priority_4
where 1 = 1

