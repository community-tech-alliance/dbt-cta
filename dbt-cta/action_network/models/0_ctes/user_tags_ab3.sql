{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_tags_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'tag_id',
        'user_id',
        'group_id',
        'created_at',
        'updated_at',
    ]) }} as _airbyte_user_tags_hashid,
    tmp.*
from {{ ref('user_tags_ab2') }} as tmp
-- user_tags
where 1 = 1
