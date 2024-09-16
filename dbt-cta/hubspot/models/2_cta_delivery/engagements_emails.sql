select *
from {{ source('cta', 'engagements_emails_base') }}
