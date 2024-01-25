{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('sent_emails_ab4') }}
select
    recipients_count,
    event_id,
    list_id,
    email_template_id,
    subject,
    created_at,
    {{ adapter.quote('from') }},
    id,
    team_id,
    body,
    sender_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_normalized_at,
    _airbyte_sent_emails_hashid
from {{ ref('sent_emails_ab4') }}
-- sent_emails from {{ source('cta', '_airbyte_raw_sent_emails') }}
