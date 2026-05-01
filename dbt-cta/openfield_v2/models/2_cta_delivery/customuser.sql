select *
from {{ source('cta', 'customuser_base') }}
