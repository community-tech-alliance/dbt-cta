{{ config(
    unique_key = ["ticket_id", "email"],
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
) }}

select
  id as ticket_id,
  email
from {{ ref("tickets_ab3") }} tickets, UNNEST(tickets.cc_emails) as email
-- ticket from {{ source('cta', '_airbyte_raw_tickets') }}
where 1 = 1