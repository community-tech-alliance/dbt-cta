select *
from {{ source('cta', 'oneclick_storeduser_base') }}
