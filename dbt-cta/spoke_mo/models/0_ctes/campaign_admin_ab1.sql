{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_campaign_admin" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['ingest_method'], ['ingest_method']) }} as ingest_method,
    {{ json_extract_scalar('_airbyte_data', ['ingest_data_reference'], ['ingest_data_reference']) }} as ingest_data_reference,
    {{ json_extract_scalar('_airbyte_data', ['deleted_optouts_count'], ['deleted_optouts_count']) }} as deleted_optouts_count,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['ingest_success'], ['ingest_success']) }} as ingest_success,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['ingest_result'], ['ingest_result']) }} as ingest_result,
    {{ json_extract_scalar('_airbyte_data', ['duplicate_contacts_count'], ['duplicate_contacts_count']) }} as duplicate_contacts_count,
    {{ json_extract_scalar('_airbyte_data', ['contacts_count'], ['contacts_count']) }} as contacts_count,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- campaign_admin
where 1 = 1
