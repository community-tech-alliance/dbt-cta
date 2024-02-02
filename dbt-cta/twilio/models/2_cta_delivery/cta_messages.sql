select *
from {{ source('cta','messages_base') }}
