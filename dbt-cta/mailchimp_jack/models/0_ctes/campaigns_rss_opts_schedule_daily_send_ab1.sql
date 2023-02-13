{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_rss_opts_schedule') }}
select
    _airbyte_schedule_hashid,
    {{ json_extract_scalar('daily_send', ['friday'], ['friday']) }} as friday,
    {{ json_extract_scalar('daily_send', ['monday'], ['monday']) }} as monday,
    {{ json_extract_scalar('daily_send', ['sunday'], ['sunday']) }} as sunday,
    {{ json_extract_scalar('daily_send', ['tuesday'], ['tuesday']) }} as tuesday,
    {{ json_extract_scalar('daily_send', ['saturday'], ['saturday']) }} as saturday,
    {{ json_extract_scalar('daily_send', ['thursday'], ['thursday']) }} as thursday,
    {{ json_extract_scalar('daily_send', ['wednesday'], ['wednesday']) }} as wednesday,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_rss_opts_schedule') }} as table_alias
-- daily_send at campaigns/rss_opts/schedule/daily_send
where 1 = 1
and daily_send is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

