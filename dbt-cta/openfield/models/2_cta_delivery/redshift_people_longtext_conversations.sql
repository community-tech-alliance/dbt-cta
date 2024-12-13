select *
from {{ source('cta','redshift_people_longtext_conversations_base') }}
