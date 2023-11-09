{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('purchase_orders_Line_ItemBasedExpenseLineDetail_base') }}
select
    _airbyte_ItemBasedExpenseLineDetail_hashid,
    {{ json_extract_scalar('TaxCodeRef', ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchase_orders_Line_ItemBasedExpenseLineDetail_base') }} as table_alias
-- TaxCodeRef at purchase_orders/Line/ItemBasedExpenseLineDetail/TaxCodeRef
where 1 = 1
and TaxCodeRef is not null

