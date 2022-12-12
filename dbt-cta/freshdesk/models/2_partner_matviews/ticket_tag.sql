-- Final Materialized View SQL model
-- depends_on: {{ ref('ticket_base') }}
select
  id as ticket_id,
  tag
from {{ source('cta', 'ticket_base') }} tickets, UNNEST(tickets.tags) as tag
-- ticket_base from {{ source('cta', 'ticket_base') }}