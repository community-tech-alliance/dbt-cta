select *
from {{ source('cta','redshift_people_list_conversations_base') }}
