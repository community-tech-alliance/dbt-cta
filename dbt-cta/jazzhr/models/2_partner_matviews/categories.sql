select
    date_created,
    name,
    id,
    created_by,
    status,
    _airbyte_extracted_at,
    _airbyte_categories_hashid
from {{ source('cta','categories_base') }}
