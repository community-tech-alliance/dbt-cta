{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_tax_agencies') }}
select
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract_scalar('_airbyte_data', ['TaxTrackedOnPurchases'], ['TaxTrackedOnPurchases']) }} as TaxTrackedOnPurchases,
    {{ json_extract_scalar('_airbyte_data', ['sparse'], ['sparse']) }} as sparse,
    {{ json_extract_scalar('_airbyte_data', ['TaxRegistrationNumber'], ['TaxRegistrationNumber']) }} as TaxRegistrationNumber,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['DisplayName'], ['DisplayName']) }} as DisplayName,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('_airbyte_data', ['TaxTrackedOnSales'], ['TaxTrackedOnSales']) }} as TaxTrackedOnSales,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_tax_agencies') }} as table_alias
-- tax_agencies
where 1 = 1

