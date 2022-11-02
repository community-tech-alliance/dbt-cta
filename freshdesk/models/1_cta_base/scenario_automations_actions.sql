{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "freshdesk_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('scenario_automations_actions_ab3') }}
select
    _airbyte_scenario_automations_hashid,
    name,
    value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_actions_hashid
from {{ ref('scenario_automations_actions_ab3') }}
-- actions at scenario_automations/actions from {{ ref('scenario_automations') }}
where 1 = 1

