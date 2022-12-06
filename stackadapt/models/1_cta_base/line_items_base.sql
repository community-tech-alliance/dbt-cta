{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace
) }}
-- Final base SQL model
-- depends_on: {{ ref('line_items_ab3') }}
select
    id,
    name,
    state,
    budget,
    SAFE_CAST(end_date as date) as end_date,
    daily_cap,
    SAFE_CAST(start_date as date) as start_date,
    budget_type,
    pace_evenly,
    revenue_type,
    advertiser_id,
    revenue_value,
    all_campaign_ids,
    black_list_options,
    purchase_order_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_line_items_hashid
from {{ ref('line_items_ab3') }}
-- line_items from {{ source('cta', '_airbyte_raw_line_items') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

