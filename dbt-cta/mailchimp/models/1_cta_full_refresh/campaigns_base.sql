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
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace,
    unique_key = '_airbyte_raw_id',
) }}

-- depends_on: {{ ref('campaigns_ab4') }}
select
    id,
    type,
    status,
    web_id,
    rss_opts,
    settings,
    tracking,
    send_time,
    recipients,
    resendable,
    archive_url,
    create_time,
    emails_sent,
    social_card,
    content_type,
    ab_split_opts,
    report_summary,
    delivery_status,
    long_archive_url,
    variate_settings,
    parent_campaign_id,
    needs_block_refresh,
    _airbyte_raw_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaigns_hashid
from {{ ref('campaigns_ab4') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}