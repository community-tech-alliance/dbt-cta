{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('folders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'depth',
        'updated_at',
        'parent_id',
        'name',
        'extras',
        'created_at',
        'id',
        'lft',
        'rgt',
    ]) }} as _airbyte_folders_hashid,
    tmp.*
from {{ ref('folders_ab2') }} tmp
-- folders
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

