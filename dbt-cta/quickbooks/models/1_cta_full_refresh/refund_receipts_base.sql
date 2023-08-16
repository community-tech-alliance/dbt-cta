{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('refund_receipts_ab3') }}
select
    BillAddr,
    CurrencyRef,
    ExchangeRate,
    TxnDate,
    airbyte_cursor,
    CustomerMemo,
    Line,
    SyncToken,
    DepositToAccountRef,
    sparse,
    TotalAmt,
    HomeTotalAmt,
    MetaData,
    PaymentMethodRef,
    domain,
    DocNumber,
    CustomField,
    Id,
    PrintStatus,
    CustomerRef,
    Balance,
    BillEmail,
    ApplyTaxAfterDiscount,
    TxnTaxDetail,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_refund_receipts_hashid
from {{ ref('refund_receipts_ab3') }}
-- refund_receipts from {{ source('cta', '_airbyte_raw_refund_receipts') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}