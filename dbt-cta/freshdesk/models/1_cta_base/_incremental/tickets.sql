{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('tickets_ab3') }}
select
    id,
    spam,
    tags,
    type,
    stats,
    due_by,
    source,
    status,
    subject,
    group_id,
    priority,
    cc_emails,
    fr_due_by,
    nr_due_by,
    requester,
    to_emails,
    company_id,
    created_at,
    fwd_emails,
    product_id,
    updated_at,
    description,
    fr_escalated,
    is_escalated,
    nr_escalated,
    requester_id,
    responder_id,
    custom_fields,
    email_config_id,
    reply_cc_emails,
    association_type,
    description_text,
    ticket_cc_emails,
    associated_tickets_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tickets_hashid
from {{ ref('tickets_ab3') }}
-- tickets from {{ source('cta', '_airbyte_raw_tickets') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

