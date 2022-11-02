{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('scenario_automations_actions_ab1') }}
select
    _airbyte_scenario_automations_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(value as {{ dbt_utils.type_string() }}) as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('scenario_automations_actions_ab1') }}
-- actions at scenario_automations/actions
where 1 = 1

