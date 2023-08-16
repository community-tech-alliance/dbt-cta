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
-- depends_on: {{ ref('refund_receipts_BillAddr_ab3') }}
select
    _airbyte_refund_receipts_hashid,
    Line4,
    Long,
    Id,
    Line1,
    Lat,
    Line2,
    Line3,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_BillAddr_hashid
from {{ ref('refund_receipts_BillAddr_ab3') }}
-- BillAddr at refund_receipts/BillAddr from {{ ref('refund_receipts') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}