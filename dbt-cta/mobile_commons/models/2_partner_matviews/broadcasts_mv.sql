select *
from {{ source('cta', 'broadcasts_base') }}
