{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('scenario_automations_ab3') }}
select
    id,
    name,
    actions,
    private,
    created_at,
    updated_at,
    description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_scenario_automations_hashid
from {{ ref('scenario_automations_ab3') }}
-- scenario_automations from {{ source('freshdesk_partner_a', '_airbyte_raw_scenario_automations') }}
where 1 = 1

