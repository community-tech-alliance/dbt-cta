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
-- depends_on: {{ ref('tax_agencies_ab3') }}
select
    SyncToken,
    TaxTrackedOnPurchases,
    sparse,
    TaxRegistrationNumber,
    MetaData,
    domain,
    airbyte_cursor,
    DisplayName,
    Id,
    TaxTrackedOnSales,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tax_agencies_hashid
from {{ ref('tax_agencies_ab3') }}
-- tax_agencies from {{ source('cta', '_airbyte_raw_tax_agencies') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}