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
    _airbyte_emitted_at,
    _airbyte_users_export_hashid
from {{ source('cta','users_export_base') }}