{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'mailing_id'
) }}
-- SQL model to select normalized fields from the summary_mailing source
-- depends_on: {{ source('cta', 'summary_mailing') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    mailing_id,
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
    total_raw_clicks,
    total_unsubscribes
from {{ source('cta', 'summary_mailing') }}
