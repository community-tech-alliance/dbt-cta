{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_campaigns_hashid'
) }}

-- depends_on: {{ source('cta', 'campaigns_base') }}

SELECT
     _airbyte_campaigns_hashid
    ,MAX(id) as id
    ,MAX(type) as type
    ,MAX(status) as status
    ,MAX(web_id) as web_id
    ,MAX(rss_opts) as rss_opts
    ,MAX(settings) as settings
    ,MAX(tracking) as tracking
    ,MAX(send_time) as send_time
    ,MAX(recipients) as recipients
    ,MAX(resendable) as resendable
    ,MAX(archive_url) as archive_url
    ,MAX(create_time) as create_time
    ,MAX(emails_sent) as emails_sent
    ,MAX(social_card) as social_card
    ,MAX(content_type) as content_type
    ,MAX(ab_split_opts) as ab_split_opts
    ,MAX(report_summary) as report_summary
    ,MAX(delivery_status) as delivery_status
    ,MAX(long_archive_url) as long_archive_url
    ,MAX(variate_settings) as variate_settings
    ,MAX(parent_campaign_id) as parent_campaign_id
    ,MAX(needs_block_refresh) as needs_block_refresh
    ,MAX(_airbyte_raw_id) as _airbyte_raw_id
    ,MAX(_airbyte_extracted_at) as _airbyte_extracted_at

from {{ source('cta', 'campaigns_base') }} as table_alias
GROUP BY _airbyte_campaigns_hashid