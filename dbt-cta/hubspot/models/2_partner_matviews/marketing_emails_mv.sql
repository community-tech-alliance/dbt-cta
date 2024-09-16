select *
from {{ source('cta', 'marketing_emails_base') }}
