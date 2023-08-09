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
-- depends_on: {{ ref('credit_memos_Line_SalesItemLineDetail_ab3') }}
select
    _airbyte_Line_hashid,
    UnitPrice,
    TaxCodeRef,
    Qty,
    ItemRef,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_SalesItemLineDetail_hashid
from {{ ref('credit_memos_Line_SalesItemLineDetail_ab3') }}
-- SalesItemLineDetail at credit_memos/Line/SalesItemLineDetail from {{ ref('credit_memos_Line') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}