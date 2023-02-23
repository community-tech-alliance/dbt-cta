select
    sid,
    uri,
    parent_sid,
    account_sid,
    content_type,
    date_created,
    date_updated,
from {{ source('cta','message_media_base') }}