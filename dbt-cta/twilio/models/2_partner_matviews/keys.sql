select
    sid,
    date_created,
    date_updated,
    friendly_name,
from {{ source('cta','keys_base') }}