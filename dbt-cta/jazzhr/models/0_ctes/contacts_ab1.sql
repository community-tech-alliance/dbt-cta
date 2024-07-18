{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_contacts" %}

{{ config(
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', '_raw__stream_contactss') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    airbyte_raw_id,
    airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', '_raw__stream_contacts') }} as table_alias
-- contacts
where 1 = 1

