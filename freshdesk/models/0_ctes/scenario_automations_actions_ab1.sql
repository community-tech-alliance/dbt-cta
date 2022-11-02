{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('scenario_automations') }}
{{ unnest_cte(ref('scenario_automations'), 'scenario_automations', 'actions') }}
select
    _airbyte_scenario_automations_hashid,
    {{ json_extract_scalar(unnested_column_value('actions'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('actions'), ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('scenario_automations') }} as table_alias
-- actions at scenario_automations/actions
{{ cross_join_unnest('scenario_automations', 'actions') }}
where 1 = 1
and actions is not null

