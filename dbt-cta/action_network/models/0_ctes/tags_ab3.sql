{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tags_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'uuid',
        'notes',
        'group_id',
        'created_at',
        'updated_at',
        'parent_group_id',
        'sent_to_children',
    ]) }} as _airbyte_tags_hashid,
    tmp.*
from {{ ref('tags_ab2') }} as tmp
-- tags
where 1 = 1
