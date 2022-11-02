{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('freshdesk_partner_a', '_airbyte_raw_solution_articles') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['hits'], ['hits']) }} as hits,
    {{ json_extract_string_array('_airbyte_data', ['tags'], ['tags']) }} as tags,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['agent_id'], ['agent_id']) }} as agent_id,
    {{ json_extract('table_alias', '_airbyte_data', ['seo_data'], ['seo_data']) }} as seo_data,
    {{ json_extract_scalar('_airbyte_data', ['folder_id'], ['folder_id']) }} as folder_id,
    {{ json_extract_scalar('_airbyte_data', ['thumbs_up'], ['thumbs_up']) }} as thumbs_up,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['category_id'], ['category_id']) }} as category_id,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['thumbs_down'], ['thumbs_down']) }} as thumbs_down,
    {{ json_extract_scalar('_airbyte_data', ['description_text'], ['description_text']) }} as description_text,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('freshdesk_partner_a', '_airbyte_raw_solution_articles') }} as table_alias
-- solution_articles
where 1 = 1

