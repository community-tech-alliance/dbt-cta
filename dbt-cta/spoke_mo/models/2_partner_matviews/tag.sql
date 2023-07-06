select
    is_deleted,
    updated_at,
    organization_id,
    name,
    created_at,
    description,
    id,
    {{ adapter.quote('group') }},
    _airbyte_emitted_at,
    _airbyte_tag_hashid
from {{ source('cta','tag_base') }}