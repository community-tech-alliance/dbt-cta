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
-- depends_on: {{ ref('estimates_TxnTaxDetail_ab3') }}
select
    _airbyte_estimates_hashid,
    TotalTax,
    TxnTaxCodeRef,
    TaxLine,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_TxnTaxDetail_hashid
from {{ ref('estimates_TxnTaxDetail_ab3') }}
-- TxnTaxDetail at estimates/TxnTaxDetail from {{ ref('estimates') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}