select *
from {{ source('cta', 'client_metadata_base') }}
