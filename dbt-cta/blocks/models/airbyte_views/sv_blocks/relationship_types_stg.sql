{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('relationship_types_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        'name',
        'created_at',
        'id',
    ]) }} as _airbyte_relationship_types_hashid,
    tmp.*
from {{ ref('relationship_types_ab2') }} tmp
-- relationship_types
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

