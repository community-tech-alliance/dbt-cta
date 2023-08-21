{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('entity_sync_states_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'last_run',
        'entity_id',
        'created_at',
        'updated_at',
        'comparable_id',
        'comparable_type',
        'external_entity_id',
        'external_compared_id',
        'external_compared_type',
        'service_integration_type',
        'organization_integration_id',
    ]) }} as _airbyte_entity_sync_states_hashid,
    tmp.*
from {{ ref('entity_sync_states_ab2') }} as tmp
-- entity_sync_states
where 1 = 1
