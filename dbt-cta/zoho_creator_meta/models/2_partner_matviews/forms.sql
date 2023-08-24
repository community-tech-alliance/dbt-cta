select
    application_link_name,
    type,
    link_name,
    display_name,
    workspace_name,
    _airbyte_emitted_at,
    _airbyte_forms_hashid
from {{ source('cta','forms_base') }}
