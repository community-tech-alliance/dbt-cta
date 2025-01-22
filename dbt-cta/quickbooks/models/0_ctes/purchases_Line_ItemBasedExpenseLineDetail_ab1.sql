{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('purchases_Line_base') }}
select
    _airbyte_Line_hashid,
    {{ json_extract_scalar('ItemBasedExpenseLineDetail', ['UnitPrice'], ['UnitPrice']) }} as UnitPrice,
    {{ json_extract('table_alias', 'ItemBasedExpenseLineDetail', ['TaxCodeRef'], ['TaxCodeRef']) }} as TaxCodeRef,
    {{ json_extract_scalar('ItemBasedExpenseLineDetail', ['BillableStatus'], ['BillableStatus']) }} as BillableStatus,
    {{ json_extract_scalar('ItemBasedExpenseLineDetail', ['Qty'], ['Qty']) }} as Qty,
    {{ json_extract('table_alias', 'ItemBasedExpenseLineDetail', ['ItemRef'], ['ItemRef']) }} as ItemRef,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchases_Line_base') }} as table_alias
-- ItemBasedExpenseLineDetail at purchases/Line/ItemBasedExpenseLineDetail
where
    1 = 1
    and ItemBasedExpenseLineDetail is not null
