select
    subfields,
    unique,
    max_char,
    type,
    choices,
    link_name,
    display_name,
    mandatory,
    form_link_name,
    application_link_name,
    _airbyte_emitted_at,
    _airbyte_fields_hashid
from {{ source('cta','fields_base') }}
