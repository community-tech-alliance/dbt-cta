{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('refund_receipts_base') }}
select
    _airbyte_refund_receipts_hashid,
    {{ json_extract_scalar('TxnTaxDetail', ['TotalTax'], ['TotalTax']) }} as TotalTax,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('refund_receipts_base') }} as table_alias
-- TxnTaxDetail at refund_receipts/TxnTaxDetail
where 1 = 1
and TxnTaxDetail is not null

