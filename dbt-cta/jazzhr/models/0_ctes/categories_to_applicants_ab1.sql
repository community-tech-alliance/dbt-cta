{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_categories_to_applicants" %}

{{ config(
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', '_raw__stream_categories_to_applicants') }}
select
    {{ json_extract_scalar('_airbyte_data', ['category_id'], ['category_id']) }} as category_id,
    {{ json_extract_scalar('_airbyte_data', ['applicant_id'], ['applicant_id']) }} as applicant_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    airbyte_raw_id,
    airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', '_raw__stream_categories_to_applicants') }} as table_alias
-- categories_to_applicants
where 1 = 1

