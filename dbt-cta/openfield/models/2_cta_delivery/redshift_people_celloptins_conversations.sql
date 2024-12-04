select *
from {{ source('cta','redshift_people_celloptins_conversations_base') }}
