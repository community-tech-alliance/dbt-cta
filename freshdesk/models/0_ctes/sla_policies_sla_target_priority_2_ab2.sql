{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sla_policies_sla_target_priority_2_ab1') }}
select
    _airbyte_sla_target_hashid,
    {{ cast_to_boolean('business_hours') }} as business_hours,
    cast(resolve_within as {{ dbt_utils.type_bigint() }}) as resolve_within,
    cast(respond_within as {{ dbt_utils.type_bigint() }}) as respond_within,
    {{ cast_to_boolean('escalation_enabled') }} as escalation_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies_sla_target_priority_2_ab1') }}
-- priority_2 at sla_policies/sla_target/priority_2
where 1 = 1

