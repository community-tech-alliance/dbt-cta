{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('categories') }}
select
    _airbyte_categories_hashid,
    {{ json_extract_scalar('category_data', ['name'], ['name']) }} as name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('categories') }} as table_alias
-- category_data at categories/category_data
where 1 = 1
and category_data is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

