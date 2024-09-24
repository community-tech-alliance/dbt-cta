select *
from {{ source('cta', 'deliveries_base') }}
