{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_tax_rates') }}
select
    {{ json_extract('table_alias', '_airbyte_data', ['AgencyRef'], ['AgencyRef']) }} as AgencyRef,
    {{ json_extract_scalar('_airbyte_data', ['RateValue'], ['RateValue']) }} as RateValue,
    {{ json_extract_scalar('_airbyte_data', ['Description'], ['Description']) }} as Description,
    {{ json_extract_scalar('_airbyte_data', ['DisplayType'], ['DisplayType']) }} as DisplayType,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['Name'], ['Name']) }} as Name,
    {{ json_extract_scalar('_airbyte_data', ['SpecialTaxType'], ['SpecialTaxType']) }} as SpecialTaxType,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract('table_alias', '_airbyte_data', ['EffectiveTaxRate']) }} as EffectiveTaxRate,
    {{ json_extract_scalar('_airbyte_data', ['Active'], ['Active']) }} as Active,
    {{ json_extract_scalar('_airbyte_data', ['sparse'], ['sparse']) }} as sparse,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_tax_rates') }} as table_alias
-- tax_rates
where 1 = 1

