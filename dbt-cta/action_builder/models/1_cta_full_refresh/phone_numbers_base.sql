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
-- depends_on: {{ ref('phone_numbers_ab3') }}
select
    id,
    ext,
    dw_id,
    number,
    source,
    status,
    owner_id,
    created_at,
    owner_type,
    updated_at,
    interact_id,
    number_type,
    created_by_id,
    updated_by_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_numbers_hashid
from {{ ref('phone_numbers_ab3') }}
-- phone_numbers from {{ source('cta', '_airbyte_raw_phone_numbers') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}