{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_items') }}
select
    {{ json_extract_scalar('_airbyte_data', ['Description'], ['Description']) }} as Description,
    {{ json_extract_scalar('_airbyte_data', ['QtyOnHand'], ['QtyOnHand']) }} as QtyOnHand,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['FullyQualifiedName'], ['FullyQualifiedName']) }} as FullyQualifiedName,
    {{ json_extract_scalar('_airbyte_data', ['PurchaseDesc'], ['PurchaseDesc']) }} as PurchaseDesc,
    {{ json_extract_scalar('_airbyte_data', ['TrackQtyOnHand'], ['TrackQtyOnHand']) }} as TrackQtyOnHand,
    {{ json_extract('table_alias', '_airbyte_data', ['AssetAccountRef'], ['AssetAccountRef']) }} as AssetAccountRef,
    {{ json_extract('table_alias', '_airbyte_data', ['IncomeAccountRef'], ['IncomeAccountRef']) }} as IncomeAccountRef,
    {{ json_extract_scalar('_airbyte_data', ['Name'], ['Name']) }} as Name,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract_scalar('_airbyte_data', ['Type'], ['Type']) }} as Type,
    {{ json_extract_scalar('_airbyte_data', ['Active'], ['Active']) }} as Active,
    {{ json_extract_scalar('_airbyte_data', ['UnitPrice'], ['UnitPrice']) }} as UnitPrice,
    {{ json_extract('table_alias', '_airbyte_data', ['ExpenseAccountRef'], ['ExpenseAccountRef']) }} as ExpenseAccountRef,
    {{ json_extract_scalar('_airbyte_data', ['sparse'], ['sparse']) }} as sparse,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['PurchaseCost'], ['PurchaseCost']) }} as PurchaseCost,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['InvStartDate'], ['InvStartDate']) }} as InvStartDate,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('_airbyte_data', ['Taxable'], ['Taxable']) }} as Taxable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_items') }} as table_alias
-- items
where 1 = 1

