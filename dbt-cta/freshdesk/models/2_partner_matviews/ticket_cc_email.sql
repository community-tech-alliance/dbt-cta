-- Final Materialized View SQL model
-- depends_on: {{ ref('ticket_base') }}
select
  _airbyte_emitted_at,
  id as ticket_id,
  email
from {{ source('cta', 'ticket_base') }} tickets, UNNEST(tickets.cc_emails) as email
-- ticket_base from {{ source('cta', 'ticket_base') }}