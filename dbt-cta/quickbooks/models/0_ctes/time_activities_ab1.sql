{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_time_activities" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
select
    {{ json_extract('table_alias', '_airbyte_data', ['EmployeeRef'], ['EmployeeRef']) }} as EmployeeRef,
    {{ json_extract_scalar('_airbyte_data', ['NameOf'], ['NameOf']) }} as NameOf,
    {{ json_extract_scalar('_airbyte_data', ['Description'], ['Description']) }} as Description,
    {{ json_extract_scalar('_airbyte_data', ['Hours'], ['Hours']) }} as Hours,
    {{ json_extract_scalar('_airbyte_data', ['TxnDate'], ['TxnDate']) }} as TxnDate,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['Minutes'], ['Minutes']) }} as Minutes,
    {{ json_extract_scalar('_airbyte_data', ['HourlyRate'], ['HourlyRate']) }} as HourlyRate,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract_scalar('_airbyte_data', ['sparse'], ['sparse']) }} as sparse,
    {{ json_extract_scalar('_airbyte_data', ['BillableStatus'], ['BillableStatus']) }} as BillableStatus,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract('table_alias', '_airbyte_data', ['ItemRef'], ['ItemRef']) }} as ItemRef,
    {{ json_extract('table_alias', '_airbyte_data', ['CustomerRef'], ['CustomerRef']) }} as CustomerRef,
    {{ json_extract_scalar('_airbyte_data', ['Taxable'], ['Taxable']) }} as Taxable,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
-- time_activities
where 1 = 1
