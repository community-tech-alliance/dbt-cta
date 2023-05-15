select
    _airbyte_emitted_at,
    id,
    name,
    notes,
    footer,
    header,
    user_id,
    group_id,
    created_at,
    syndicated,
    updated_at,
    logo_file_name,
    logo_file_size,
    logo_dimensions,
    logo_content_type
from {{ source('cta','page_wrappers_base') }}