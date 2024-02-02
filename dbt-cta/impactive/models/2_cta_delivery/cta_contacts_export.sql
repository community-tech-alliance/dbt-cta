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
    _airbyte_emitted_at,
    _airbyte_contacts_export_hashid
from {{ source('cta','contacts_export_base') }}