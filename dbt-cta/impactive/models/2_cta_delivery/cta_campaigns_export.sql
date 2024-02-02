select
    updated_at,
    name,
    created_at,
    id,
    slug,
    exported_at,
    _airbyte_emitted_at,
    _airbyte_campaigns_export_hashid
from {{ source('cta','campaigns_export_base') }}