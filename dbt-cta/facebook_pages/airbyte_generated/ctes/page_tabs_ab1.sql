{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_array('tabs', ['data'], ['data']) }} as data,
    {{ json_extract('table_alias', 'tabs', ['paging'], ['paging']) }} as paging,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- tabs at page/tabs
where 1 = 1
and tabs is not null

