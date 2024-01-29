{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('comments_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'title',
        'content',
        'user_id',
        'group_id',
        'parent_id',
        'created_at',
        'updated_at',
        'user_list_id',
        'commentable_id',
        'commentable_type',
    ]) }} as _airbyte_comments_hashid,
    tmp.*
from {{ ref('comments_ab2') }} as tmp
-- comments
where 1 = 1
