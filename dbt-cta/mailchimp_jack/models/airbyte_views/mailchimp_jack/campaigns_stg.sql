{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_mailchimp_jack",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'type',
        'status',
        'web_id',
        object_to_string('rss_opts'),
        object_to_string('settings'),
        object_to_string('tracking'),
        'send_time',
        object_to_string('recipients'),
        boolean_to_string('resendable'),
        'archive_url',
        'create_time',
        'emails_sent',
        object_to_string('social_card'),
        'content_type',
        object_to_string('ab_split_opts'),
        object_to_string('report_summary'),
        object_to_string('delivery_status'),
        'long_archive_url',
        object_to_string('variate_settings'),
        'parent_campaign_id',
        boolean_to_string('needs_block_refresh'),
    ]) }} as _airbyte_campaigns_hashid,
    tmp.*
from {{ ref('campaigns_ab2') }} tmp
-- campaigns
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

