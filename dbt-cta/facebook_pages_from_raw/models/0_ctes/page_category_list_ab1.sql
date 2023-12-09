{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
{{ unnest_cte(ref('page'), 'page', 'category_list') }}
select
    _airbyte_page_hashid,
    {{ json_extract_scalar(unnested_column_value('category_list'), ['api_enum'], ['api_enum']) }} as api_enum,
    {{ json_extract_scalar(unnested_column_value('category_list'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('category_list'), ['id'], ['id']) }} as id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- category_list at page/category_list
{{ cross_join_unnest('page', 'category_list') }}
where 1 = 1
and category_list is not null

