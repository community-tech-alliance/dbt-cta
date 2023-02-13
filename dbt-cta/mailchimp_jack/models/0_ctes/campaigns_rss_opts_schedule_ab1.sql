{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_rss_opts') }}
select
    _airbyte_rss_opts_hashid,
    {{ json_extract_scalar('schedule', ['hour'], ['hour']) }} as hour,
    {{ json_extract('table_alias', 'schedule', ['daily_send'], ['daily_send']) }} as daily_send,
    {{ json_extract_scalar('schedule', ['weekly_send_day'], ['weekly_send_day']) }} as weekly_send_day,
    {{ json_extract_scalar('schedule', ['monthly_send_date'], ['monthly_send_date']) }} as monthly_send_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_rss_opts') }} as table_alias
-- schedule at campaigns/rss_opts/schedule
where 1 = 1
and schedule is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

