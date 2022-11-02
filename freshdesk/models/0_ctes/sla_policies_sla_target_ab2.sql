{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sla_policies_sla_target_ab1') }}
select
    _airbyte_sla_policies_hashid,
    cast(priority_1 as {{ type_json() }}) as priority_1,
    cast(priority_2 as {{ type_json() }}) as priority_2,
    cast(priority_3 as {{ type_json() }}) as priority_3,
    cast(priority_4 as {{ type_json() }}) as priority_4,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies_sla_target_ab1') }}
-- sla_target at sla_policies/sla_target
where 1 = 1

