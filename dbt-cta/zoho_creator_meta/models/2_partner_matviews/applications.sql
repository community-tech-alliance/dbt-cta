select
    application_name,
    date_format,
    creation_date,
    category,
    link_name,
    time_zone,
    created_by,
    workspace_name,
    _airbyte_emitted_at,
    _airbyte_applications_hashid
from {{ source('cta','applications_base') }}
