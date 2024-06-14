select *
from {{ source('cta', 'captricity_batches_base') }}
