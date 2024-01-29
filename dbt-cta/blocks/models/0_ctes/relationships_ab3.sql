{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('relationships_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'first_person_id',
        'updated_at',
        'relationship_type_id',
        'second_person_id',
        'created_at',
        'id',
        'type',
    ]) }} as _airbyte_relationships_hashid,
    tmp.*
from {{ ref('relationships_ab2') }} tmp
-- relationships
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

