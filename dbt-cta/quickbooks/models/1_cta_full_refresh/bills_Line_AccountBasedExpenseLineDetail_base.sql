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
-- depends_on: {{ ref('bills_Line_AccountBasedExpenseLineDetail_ab3') }}
select
    _airbyte_Line_hashid,
    TaxCodeRef,
    BillableStatus,
    AccountRef,
    CustomerRef,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_AccountBasedExpenseLineDetail_hashid
from {{ ref('bills_Line_AccountBasedExpenseLineDetail_ab3') }}
-- AccountBasedExpenseLineDetail at bills/Line/AccountBasedExpenseLineDetail from {{ ref('bills_Line') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}