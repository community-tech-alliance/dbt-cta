select *
from {{ source('cta', 'petitions_signatures_base') }}
