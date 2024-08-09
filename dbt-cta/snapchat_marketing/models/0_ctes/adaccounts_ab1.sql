{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_adaccounts" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: { source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['timezone'], ['timezone']) }} as timezone,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract('table_alias', '_airbyte_data', ['regulations'], ['regulations']) }} as regulations,
    {{ json_extract_scalar('_airbyte_data', ['billing_type'], ['billing_type']) }} as billing_type,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['billing_center_id'], ['billing_center_id']) }} as billing_center_id,
    {{ json_extract_array('_airbyte_data', ['funding_source_ids'], ['funding_source_ids']) }} as funding_source_ids,
    {{ json_extract_scalar('_airbyte_data', ['client_paying_invoices'], ['client_paying_invoices']) }} as client_paying_invoices,
    {{ json_extract_scalar('_airbyte_data', ['advertiser_organization_id'], ['advertiser_organization_id']) }} as advertiser_organization_id,
    {{ json_extract_scalar('_airbyte_data', ['agency_representing_client'], ['agency_representing_client']) }} as agency_representing_client,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from { source('cta_raw', raw_table) }} as table_alias
-- adaccounts
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

