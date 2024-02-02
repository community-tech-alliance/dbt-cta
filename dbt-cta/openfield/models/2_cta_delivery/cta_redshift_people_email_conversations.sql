select *
from {{ source('cta','redshift_people_email_conversations_base') }}
