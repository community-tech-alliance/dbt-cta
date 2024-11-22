select *
from {{ source('cta', 'states_base') }}
