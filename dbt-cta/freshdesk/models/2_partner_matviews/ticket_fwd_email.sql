-- Final Materialized View SQL model
-- depends_on: {{ ref('ticket_base') }}
select
  id as ticket_id,
  email
from {{ ref("ticket_base") }} tickets, UNNEST(tickets.fwd_emails) as email
-- ticket_base from {{ source('cta', 'ticket_base') }}