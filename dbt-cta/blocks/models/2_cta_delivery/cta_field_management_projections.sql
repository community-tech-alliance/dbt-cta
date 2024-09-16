select *
from {{ source('cta', 'field_management_projections_base') }}
