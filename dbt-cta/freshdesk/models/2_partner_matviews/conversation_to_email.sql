-- Final Materialized View SQL model
-- depends_on: {{ ref('conversation_base') }}
select
    id as conversation_id
    email
from {{ ref('conversation_base') }} conversations, UNNEST(conversations.to_emails) as email
-- conversations from {{ source('cta', 'conversation_base') }}


