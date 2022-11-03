{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('conversations_ab3') }}
select
    id,
    body,
    source,
    private,
    user_id,
    category,
    incoming,
    body_text,
    cc_emails,
    ticket_id,
    to_emails,
    bcc_emails,
    created_at,
    from_email,
    updated_at,
    attachments,
    support_email,
    source_additional_info,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_conversations_hashid
from {{ ref('conversations_ab3') }}
-- conversations from {{ source('cta', '_airbyte_raw_conversations') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

