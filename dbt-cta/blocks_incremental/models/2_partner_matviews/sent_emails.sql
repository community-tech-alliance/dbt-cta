select *
from {{ source('cta','sent_emails_base') }}
