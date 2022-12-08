{{ config(
    unique_key = ["ticket_id", "tag"],
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
) }}

select
  id as ticket_id,
  tag
from {{ ref("tickets_ab3") }} tickets, UNNEST(tickets.tags) as tag
-- ticket from {{ source('cta', '_airbyte_raw_tickets') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}