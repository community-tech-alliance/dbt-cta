select
    _airbyte_emitted_at,
    id,
    key,
    name,
    bucket,
    counts,
    result,
    status,
    mappings,
    created_at,
    updated_at,
    campaign_id,
    upload_type,
    created_by_id,
    entity_type_id,
    visibility_status,
    processing_options,
    identification_field,
    _airbyte_uploads_hashid
from {{ source('cta','uploads_base') }}