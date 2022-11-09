{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('solution_articles') }}
select
    _airbyte_solution_articles_hashid,
    {{ json_extract_scalar('seo_data', ['meta_title'], ['meta_title']) }} as meta_title,
    {{ json_extract_string_array('seo_data', ['meta_keywords'], ['meta_keywords']) }} as meta_keywords,
    {{ json_extract_scalar('seo_data', ['meta_description'], ['meta_description']) }} as meta_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('solution_articles') }} as table_alias
-- seo_data at solution_articles/seo_data
where 1 = 1
and seo_data is not null

