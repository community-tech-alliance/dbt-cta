select *
from {{ source('cta','lead_tags_base') }}
