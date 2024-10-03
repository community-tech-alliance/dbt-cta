select *
from {{ source('cta','inbox_messages_base') }}
