select *
from {{ source('cta', 'fact_contacts_base') }}
