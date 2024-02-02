select
    person_lookup_id,
    created_at,
    exported_at,
    api_match_id,
    api_username,
    person_lookup_type,
    updated_at,
    api_key,
    api_type,
    success,
    van_database_mode,
    id,
    campaign_id,
    _airbyte_emitted_at,
    _airbyte_person_api_lookups_export_hashid
from {{ source('cta','person_api_lookups_export_base') }}