{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('sales_receipts_ab4') }}
select
    CurrencyRef,
    ExchangeRate,
    EmailStatus,
    ShipAddr,
    HomeTotalAmt,
    MetaData,
    PaymentMethodRef,
    DocNumber,
    PrintStatus,
    BillEmail,
    LinkedTxn,
    BillAddr,
    PaymentRefNum,
    TxnDate,
    airbyte_cursor,
    CustomerMemo,
    Line,
    SyncToken,
    DepositToAccountRef,
    sparse,
    TotalAmt,
    domain,
    CustomField,
    Id,
    CustomerRef,
    Balance,
    ApplyTaxAfterDiscount,
    TxnTaxDetail,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sales_receipts_hashid
from {{ ref('sales_receipts_ab4') }}
-- sales_receipts from {{ source('cta', '_airbyte_raw_sales_receipts') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}