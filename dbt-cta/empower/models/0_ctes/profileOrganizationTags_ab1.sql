{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_profileOrganizationTags" %}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    {{ json_extract_scalar('_airbyte_data', ['profileEid'], ['profileEid']) }} as profileEid,
    {{ json_extract_scalar('_airbyte_data', ['tagId'], ['tagId']) }} as tagId,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
where 1 = 1
