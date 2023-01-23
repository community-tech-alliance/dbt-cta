{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tag_groups_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'target_id',
        'created_at',
        'created_by',
        'updated_at',
        'target_type',
    ]) }} as _airbyte_tag_groups_hashid,
    tmp.*
from {{ ref('tag_groups_ab2') }} tmp
-- tag_groups
where 1 = 1

