{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('entity_connections_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'status',
        boolean_to_string('imported'),
        'created_at',
        'deleted_at',
        'updated_at',
        'campaign_id',
        'interact_id',
        'to_entity_id',
        'created_by_id',
        'deleted_by_id',
        'updated_by_id',
        'from_entity_id',
        'entity_connection_type_id',
    ]) }} as _airbyte_entity_connections_hashid,
    tmp.*
from {{ ref('entity_connections_ab2') }} as tmp
-- entity_connections
where 1 = 1
