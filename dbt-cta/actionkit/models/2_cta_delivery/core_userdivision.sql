select *
from {{ source('cta', 'core_userdivision_base') }}
