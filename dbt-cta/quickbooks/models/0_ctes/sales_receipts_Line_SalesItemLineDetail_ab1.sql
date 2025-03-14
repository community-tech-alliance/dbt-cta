{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sales_receipts_Line_base') }}
select
    _airbyte_Line_hashid,
    {{ json_extract_scalar('SalesItemLineDetail', ['UnitPrice'], ['UnitPrice']) }} as UnitPrice,
    {{ json_extract('table_alias', 'SalesItemLineDetail', ['TaxCodeRef'], ['TaxCodeRef']) }} as TaxCodeRef,
    {{ json_extract_scalar('SalesItemLineDetail', ['Qty'], ['Qty']) }} as Qty,
    {{ json_extract('table_alias', 'SalesItemLineDetail', ['ItemRef'], ['ItemRef']) }} as ItemRef,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sales_receipts_Line_base') }} as table_alias
-- SalesItemLineDetail at sales_receipts/Line/SalesItemLineDetail
where
    1 = 1
    and SalesItemLineDetail is not null
