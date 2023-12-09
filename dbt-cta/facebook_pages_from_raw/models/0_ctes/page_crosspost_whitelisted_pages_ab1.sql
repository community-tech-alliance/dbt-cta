{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_array('crosspost_whitelisted_pages', ['data'], ['data']) }} as data,
    {{ json_extract('table_alias', 'crosspost_whitelisted_pages', ['paging'], ['paging']) }} as paging,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- crosspost_whitelisted_pages at page/crosspost_whitelisted_pages
where 1 = 1
and crosspost_whitelisted_pages is not null

