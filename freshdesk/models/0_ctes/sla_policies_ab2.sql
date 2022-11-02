{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sla_policies_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    {{ cast_to_boolean('active') }} as active,
    cast(position as {{ dbt_utils.type_bigint() }}) as position,
    cast(escalation as {{ type_json() }}) as escalation,
    {{ cast_to_boolean('is_default') }} as is_default,
    cast(sla_target as {{ type_json() }}) as sla_target,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(applicable_to as {{ type_json() }}) as applicable_to,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies_ab1') }}
-- sla_policies
where 1 = 1

