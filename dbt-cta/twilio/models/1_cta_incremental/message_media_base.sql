{{ config(
    unique_key = 'sid'
) }}

-- Final base SQL model
-- depends_on: {{ ref('message_media_ab3') }}
select
    sid,
    uri,
    parent_sid,
    account_sid,
    content_type,
    date_created,
    date_updated
from {{ ref('message_media_ab3') }}
