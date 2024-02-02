select *
from {{ source('cta','redshift_people_shorttext_conversations_base') }}
