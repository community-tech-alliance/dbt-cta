{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_campaigns_hashid'
) }}

-- depends_on: {{ source('cta', 'campaigns_base') }}

select
    _airbyte_campaigns_hashid,
    max(id) as id,
    max(type) as type,
    max(status) as status,
    max(web_id) as web_id,
    max(rss_opts) as rss_opts,
    max(settings) as settings,
    max(tracking) as tracking,
    max(send_time) as send_time,
    max(recipients) as recipients,
    max(resendable) as resendable,
    max(archive_url) as archive_url,
    max(create_time) as create_time,
    max(emails_sent) as emails_sent,
    max(social_card) as social_card,
    max(content_type) as content_type,
    max(ab_split_opts) as ab_split_opts,
    max(report_summary) as report_summary,
    max(delivery_status) as delivery_status,
    max(long_archive_url) as long_archive_url,
    max(variate_settings) as variate_settings,
    max(parent_campaign_id) as parent_campaign_id,
    max(needs_block_refresh) as needs_block_refresh,
    max(_airbyte_raw_id) as _airbyte_raw_id,
    max(_airbyte_extracted_at) as _airbyte_extracted_at

from {{ source('cta', 'campaigns_base') }}
group by _airbyte_campaigns_hashid
