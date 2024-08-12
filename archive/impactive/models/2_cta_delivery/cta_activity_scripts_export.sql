select
    updated_at,
    name,
    activity_id,
    created_at,
    id,
    script_type,
    media_url,
    script,
    campaign_id,
    exported_at,
    next_scripts,
    _airbyte_emitted_at,
    _airbyte_activity_scripts_export_hashid
from {{ source('cta','activity_scripts_export_base') }}