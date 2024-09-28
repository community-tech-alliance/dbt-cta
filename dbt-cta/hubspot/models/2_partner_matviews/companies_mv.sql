select *
from {{ source('cta', 'companies_base') }}
