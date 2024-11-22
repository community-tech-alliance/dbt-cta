select *
from {{ source('cta', 'metrics_base') }}
