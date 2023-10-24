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
-- depends_on: {{ ref('users_export_ab3') }}
select
    num_contacts_synced,
    selected_voterbase_id,
    city,
    recruited_by_id,
    recruited_by,
    actions_performed,
    created_at,
    reports_filled,
    van_id,
    updated_at,
    supplied_zip_code,
    id,
    state,
    first_name,
    email,
    campaign_id,
    num_contacts_matched_in_district,
    actions_completed,
    last_name,
    num_contacts_matched,
    exported_at,
    supplied_state_abbrev,
    phone,
    invites_sent,
    last_active_at,
    last_seen_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_users_export_hashid
from {{ ref('users_export_ab3') }}
-- users_export from {{ source('cta', '_airbyte_raw_users_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}