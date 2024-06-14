select *
from {{ source('cta', 'event_documents_base') }}
