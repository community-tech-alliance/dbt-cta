{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_live_videos_ab1') }}
select
    _airbyte_page_hashid,
    data,
    cast(paging as {{ type_json() }}) as paging,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_live_videos_ab1') }}
-- live_videos at page/live_videos
where 1 = 1

