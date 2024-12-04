select *
from {{ source('cta','redshift_people_name_conversations_base') }}
