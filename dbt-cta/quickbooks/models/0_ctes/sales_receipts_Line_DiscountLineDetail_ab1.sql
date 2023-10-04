{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sales_receipts_Line') }}
select
    _airbyte_Line_hashid,
    {{ json_extract_scalar('DiscountLineDetail', ['PercentBased'], ['PercentBased']) }} as PercentBased,
    {{ json_extract('table_alias', 'DiscountLineDetail', ['DiscountAccountRef'], ['DiscountAccountRef']) }} as DiscountAccountRef,
    {{ json_extract_scalar('DiscountLineDetail', ['DiscountPercent'], ['DiscountPercent']) }} as DiscountPercent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sales_receipts_Line') }} as table_alias
-- DiscountLineDetail at sales_receipts/Line/DiscountLineDetail
where 1 = 1
and DiscountLineDetail is not null

