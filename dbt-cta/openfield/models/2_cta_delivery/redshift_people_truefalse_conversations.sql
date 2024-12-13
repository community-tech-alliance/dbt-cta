select *
from {{ source('cta','redshift_people_truefalse_conversations_base') }}
