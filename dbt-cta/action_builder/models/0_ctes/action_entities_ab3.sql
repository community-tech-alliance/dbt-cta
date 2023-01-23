{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('action_entities_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'status',
        'action_id',
        'entity_id',
        'created_at',
        'updated_at',
        'completed_at',
        'pending_count',
        'completed_count',
    ]) }} as _airbyte_action_entities_hashid,
    tmp.*
from {{ ref('action_entities_ab2') }} tmp
-- action_entities
where 1 = 1

