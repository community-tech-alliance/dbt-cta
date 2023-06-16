{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('groupings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'collection_id',
        'updated_at',
        'name',
        'created_at',
        'description',
        'id',
        'position',
    ]) }} as _airbyte_groupings_hashid,
    tmp.*
from {{ ref('groupings_ab2') }} tmp
-- groupings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

