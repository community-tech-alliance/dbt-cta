select *
from {{ source('cta', 'ar_internal_metadata_base') }}
