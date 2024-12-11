select *
from {{ source('cta', 'landing_page_signups_base') }}
