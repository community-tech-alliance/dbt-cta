{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_videos_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        array_to_string('data'),
        object_to_string('paging'),
    ]) }} as _airbyte_videos_hashid,
    tmp.*
from {{ ref('page_videos_ab2') }} tmp
-- videos at page/videos
where 1 = 1

