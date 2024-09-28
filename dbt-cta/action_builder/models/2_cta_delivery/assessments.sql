select *
from {{ source('cta', 'assessments_base') }}
