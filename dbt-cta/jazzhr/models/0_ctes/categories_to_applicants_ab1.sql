{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_categories_to_applicants') }}
select
    {{ json_extract_scalar('_airbyte_data', ['category_id'], ['category_id']) }} as category_id,
    {{ json_extract_scalar('_airbyte_data', ['applicant_id'], ['applicant_id']) }} as applicant_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_categories_to_applicants') }} as table_alias
-- categories_to_applicants
where 1 = 1

