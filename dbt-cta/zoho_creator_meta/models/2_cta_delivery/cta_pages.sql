select
    application_link_name,
    link_name,
    display_name,
    _airbyte_emitted_at,
    _airbyte_pages_hashid
from {{ source('cta','pages_base') }}
