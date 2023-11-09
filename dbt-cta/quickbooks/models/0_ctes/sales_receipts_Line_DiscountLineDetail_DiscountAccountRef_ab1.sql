{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sales_receipts_Line_DiscountLineDetail_base') }}
select
    _airbyte_DiscountLineDetail_hashid,
    {{ json_extract_scalar('DiscountAccountRef', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('DiscountAccountRef', ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sales_receipts_Line_DiscountLineDetail_base') }} as table_alias
-- DiscountAccountRef at sales_receipts/Line/DiscountLineDetail/DiscountAccountRef
where 1 = 1
and DiscountAccountRef is not null

