{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id',
) }}

-- depends_on: {{ ref('campaigns_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'type',
        'status',
        'web_id',
        'rss_opts',
        'settings',
        'tracking',
        'send_time',
        'recipients',
        boolean_to_string('resendable'),
        'archive_url',
        'create_time',
        'emails_sent',
        'social_card',
        'content_type',
        'ab_split_opts',
        'report_summary',
        'delivery_status',
        'long_archive_url',
        'variate_settings',
        'parent_campaign_id',
        boolean_to_string('needs_block_refresh'),
    ]) }} as _airbyte_campaigns_hashid,
    tmp.*
from {{ ref('campaigns_ab2') }} as tmp
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

