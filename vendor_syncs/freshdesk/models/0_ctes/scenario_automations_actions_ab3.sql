{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('scenario_automations_actions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_scenario_automations_hashid',
        'name',
        'value',
    ]) }} as _airbyte_actions_hashid,
    tmp.*
from {{ ref('scenario_automations_actions_ab2') }} tmp
-- actions at scenario_automations/actions
where 1 = 1

