select *
from {{ source('cta','message_media_base') }}
