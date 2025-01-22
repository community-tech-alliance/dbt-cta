{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('bills_Line_base') }}
select
    _airbyte_Line_hashid,
    {{ json_extract('table_alias', 'AccountBasedExpenseLineDetail', ['TaxCodeRef'], ['TaxCodeRef']) }} as TaxCodeRef,
    {{ json_extract_scalar('AccountBasedExpenseLineDetail', ['BillableStatus'], ['BillableStatus']) }} as BillableStatus,
    {{ json_extract('table_alias', 'AccountBasedExpenseLineDetail', ['AccountRef'], ['AccountRef']) }} as AccountRef,
    {{ json_extract('table_alias', 'AccountBasedExpenseLineDetail', ['CustomerRef'], ['CustomerRef']) }} as CustomerRef,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bills_Line_base') }} as table_alias
-- AccountBasedExpenseLineDetail at bills/Line/AccountBasedExpenseLineDetail
where
    1 = 1
    and AccountBasedExpenseLineDetail is not null
