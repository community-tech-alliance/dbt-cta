{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_scd') }}
select
    _airbyte_campaigns_hashid,
    {{ json_extract_scalar('rss_opts', ['feed_url'], ['feed_url']) }} as feed_url,
    {{ json_extract('table_alias', 'rss_opts', ['schedule'], ['schedule']) }} as schedule,
    {{ json_extract_scalar('rss_opts', ['frequency'], ['frequency']) }} as frequency,
    {{ json_extract_scalar('rss_opts', ['last_sent'], ['last_sent']) }} as last_sent,
    {{ json_extract_scalar('rss_opts', ['constrain_rss_img'], ['constrain_rss_img']) }} as constrain_rss_img,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_scd') }} as table_alias
-- rss_opts at campaigns/rss_opts
where 1 = 1
and rss_opts is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

