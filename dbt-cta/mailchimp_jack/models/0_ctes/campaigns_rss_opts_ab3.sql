{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_rss_opts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_campaigns_hashid',
        'feed_url',
        object_to_string('schedule'),
        'frequency',
        'last_sent',
        boolean_to_string('constrain_rss_img'),
    ]) }} as _airbyte_rss_opts_hashid,
    tmp.*
from {{ ref('campaigns_rss_opts_ab2') }} tmp
-- rss_opts at campaigns/rss_opts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

