{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('collections_groups_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'group_id',
        'created_at',
        'updated_at',
        'collection_id',
    ]) }} as _airbyte_collections_groups_hashid,
    tmp.*
from {{ ref('collections_groups_ab2') }} tmp
-- collections_groups
where 1 = 1

