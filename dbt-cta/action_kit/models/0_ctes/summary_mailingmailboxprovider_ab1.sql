{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'summary_mailingmailboxprovider') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    opens,
    amount,
    clicks,
    delays,
    orders,
    actions,
    bounces,
    new_users,
    raw_opens,
    complaints,
    created_at,
    deliveries,
    mailing_id,
    raw_clicks,
    recipients,
    updated_at,
    bounces_all,
    finished_at,
    total_opens,
    total_clicks,
    unsubscribes,
    total_raw_opens,
    amount_converted,
    mailbox_provider,
    total_raw_clicks,
    total_unsubscribes
from {{ source('cta', 'summary_mailingmailboxprovider') }}
