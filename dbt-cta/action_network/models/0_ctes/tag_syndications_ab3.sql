{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tag_syndications_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'tag_id',
        'group_id',
        'tag_name',
        'hierarchy',
        'created_at',
        'updated_at',
        'source_group_id',
    ]) }} as _airbyte_tag_syndications_hashid,
    tmp.*
from {{ ref('tag_syndications_ab2') }} as tmp
-- tag_syndications
where 1 = 1
