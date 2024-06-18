select *
from {{ source('cta', 'coorganizations_base') }}
