{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_array('claimed_urls', ['data'], ['data']) }} as data,
    {{ json_extract('table_alias', 'claimed_urls', ['paging'], ['paging']) }} as paging,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- claimed_urls at page/claimed_urls
where 1 = 1
and claimed_urls is not null

