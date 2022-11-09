{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('scenario_automations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        array_to_string('actions'),
        boolean_to_string('private'),
        'created_at',
        'updated_at',
        'description',
    ]) }} as _airbyte_scenario_automations_hashid,
    tmp.*
from {{ ref('scenario_automations_ab2') }} tmp
-- scenario_automations
where 1 = 1

