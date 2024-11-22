select *
from {{ source('cta', 'documents_base') }}
