{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('conversation_ab3') }}
select
    ticket_id,
    id,
    body_text,
    body,
    incoming,
    support_email,
    source,
    SAFE_CAST(created_at as timestamp) as created_at,
    SAFE_CAST(updated_at as timestamp) as updated_at,
    from_email,
    user_id as contact_id,
    private,
    category,
    cc_emails,
    to_emails,
    bcc_emails,
    attachments,
    source_additional_info,
    _airbyte_ab_id,
    _airbyte_emitted_at,
from {{ ref('conversation_ab3') }}
-- conversations from {{ source('cta', '_airbyte_raw_conversations') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

