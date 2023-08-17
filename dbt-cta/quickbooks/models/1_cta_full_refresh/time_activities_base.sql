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
-- depends_on: {{ ref('time_activities_ab3') }}
select
    EmployeeRef,
    NameOf,
    Description,
    Hours,
    TxnDate,
    airbyte_cursor,
    Minutes,
    HourlyRate,
    SyncToken,
    sparse,
    BillableStatus,
    MetaData,
    domain,
    Id,
    ItemRef,
    CustomerRef,
    Taxable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_time_activities_hashid
from {{ ref('time_activities_ab3') }}
-- time_activities from {{ source('cta', '_airbyte_raw_time_activities') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}