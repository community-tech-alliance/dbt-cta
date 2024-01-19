{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('contacts_export_ab3') }}
select
    reported_requested_vbm,
    selected_voterbase_id,
    city,
    can_vbm_online,
    voter_last_name,
    created_at,
    automatic_vbm,
    zip_code,
    van_id,
    contact_type,
    unit_number,
    updated_at,
    can_vbm,
    id,
    mail_address,
    reported_registered,
    first_name,
    requested_absentee_form,
    email,
    campaign_id,
    mail_zip_code,
    requested_registration_form,
    voter_first_name,
    address,
    invited,
    last_name,
    mail_city,
    assigned_user_id,
    exported_at,
    reg_confirmed,
    full_name,
    pdi_id,
    state_abbrev,
    outvote_user_id,
    mail_state_abbrev,
    phone,
    can_register_online,
    vbm_confirmed,
    dwid_id,
    taggings,
    mail_unit_number,
    customizations,
    needs_attention,
    reg_state,
    vbm_state,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_contacts_export_hashid
from {{ ref('contacts_export_ab3') }}
-- contacts_export from {{ source('cta', '_airbyte_raw_contacts_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}