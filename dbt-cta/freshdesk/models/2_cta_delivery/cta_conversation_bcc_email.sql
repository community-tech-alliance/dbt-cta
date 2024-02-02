-- Final Materialized View SQL model
-- depends_on: {{ ref('conversation_base') }}
select
  _airbyte_emitted_at,
    id as conversation_id,
    email
from {{ source('cta', 'conversation_base') }} conversations, UNNEST(conversations.bcc_emails) as email
-- conversations from {{ source('cta', 'conversation_base') }}


