{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('entity_connection_types_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'created_at',
        'updated_at',
        'interact_id',
        'created_by_id',
        'updated_by_id',
        'display_position',
        'entity_type_1_id',
        'entity_type_2_id',
    ]) }} as _airbyte_entity_connection_types_hashid,
    tmp.*
from {{ ref('entity_connection_types_ab2') }} as tmp
-- entity_connection_types
where 1 = 1
