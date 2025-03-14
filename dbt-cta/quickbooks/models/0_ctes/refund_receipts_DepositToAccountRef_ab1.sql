{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('refund_receipts_base') }}
select
    _airbyte_refund_receipts_hashid,
    {{ json_extract_scalar('DepositToAccountRef', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('DepositToAccountRef', ['value'], ['value']) }} as value,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('refund_receipts_base') }}
-- DepositToAccountRef at refund_receipts/DepositToAccountRef
where
    1 = 1
    and DepositToAccountRef is not null
