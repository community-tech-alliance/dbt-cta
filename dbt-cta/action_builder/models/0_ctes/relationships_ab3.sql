{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('relationships_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        boolean_to_string('deleted'),
        'created_at',
        'deleted_at',
        'updated_at',
        'to_entity_id',
        'created_by_id',
        'deleted_by_id',
        'updated_by_id',
        'from_entity_id',
    ]) }} as _airbyte_relationships_hashid,
    tmp.*
from {{ ref('relationships_ab2') }} as tmp
-- relationships
where 1 = 1
