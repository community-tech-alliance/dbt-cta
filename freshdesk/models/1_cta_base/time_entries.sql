{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "freshdesk_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('time_entries_ab3') }}
select
    id,
    note,
    agent_id,
    billable,
    ticket_id,
    company_id,
    created_at,
    start_time,
    time_spent,
    updated_at,
    executed_at,
    timer_running,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_time_entries_hashid
from {{ ref('time_entries_ab3') }}
-- time_entries from {{ source('freshdesk_partner_a', '_airbyte_raw_time_entries') }}
where 1 = 1

