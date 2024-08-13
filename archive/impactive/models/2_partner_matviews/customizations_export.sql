select
    custom_field_slug,
    custom_field_name,
    reportable_id,
    voterbase_id,
    customizable_id,
    customizable_type,
    reported_by_email,
    custom_field_id,
    created_at,
    exported_at,
    reportable_type,
    van_id,
    updated_at,
    phone,
    user_id,
    id,
    fullname,
    reported_by_fullname,
    value,
    email,
    campaign_id,
    _airbyte_emitted_at,
    _airbyte_customizations_export_hashid
from {{ source('cta','customizations_export_base') }}