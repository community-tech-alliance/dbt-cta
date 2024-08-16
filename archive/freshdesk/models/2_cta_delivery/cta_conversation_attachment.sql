-- Final Materialized View SQL model
-- depends_on: {{ ref('conversation_base') }}
select
  _airbyte_emitted_at,
    id as conversation_id,
    SAFE_CAST(JSON_EXTRACT_SCALAR(attachment, '$.id') as int64) as id,
    JSON_EXTRACT_SCALAR(attachment, '$.content_type') as content_type,
    SAFE_CAST(JSON_EXTRACT_SCALAR(attachment, '$.size') as int64) as size,
    JSON_EXTRACT_SCALAR(attachment, '$.name') as name,
    JSON_EXTRACT_SCALAR(attachment, '$.attachment_url') as attachment_url,
    SAFE_CAST(JSON_EXTRACT_SCALAR(attachment, '$.created_at') as timestamp) as created_at,
    SAFE_CAST(JSON_EXTRACT_SCALAR(attachment, '$.updated_at') as timestamp) as updated_at,
from {{ source('cta', 'conversation_base') }} conversations, UNNEST(conversations.attachments) as attachment
-- conversations from {{ source('cta', 'conversation_base') }}


