select
    application_link_name,
    type,
    link_name,
    display_name,
    _airbyte_emitted_at,
    _airbyte_reports_hashid
from {{ source('cta','reports_base') }}
