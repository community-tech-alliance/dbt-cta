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
-- depends_on: {{ ref('invoices_Line_DiscountLineDetail_ab3') }}
select
    _airbyte_Line_hashid,
    PercentBased,
    DiscountAccountRef,
    DiscountPercent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_DiscountLineDetail_hashid
from {{ ref('invoices_Line_DiscountLineDetail_ab3') }}
-- DiscountLineDetail at invoices/Line/DiscountLineDetail from {{ ref('invoices_Line') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}