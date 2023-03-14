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
    date_updated,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_message_media_hashid
from {{ ref('message_media_ab3') }}

