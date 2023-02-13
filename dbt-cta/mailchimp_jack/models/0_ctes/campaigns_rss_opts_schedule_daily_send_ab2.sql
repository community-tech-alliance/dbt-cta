{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_rss_opts_schedule_daily_send_ab1') }}
select
    _airbyte_schedule_hashid,
    {{ cast_to_boolean('friday') }} as friday,
    {{ cast_to_boolean('monday') }} as monday,
    {{ cast_to_boolean('sunday') }} as sunday,
    {{ cast_to_boolean('tuesday') }} as tuesday,
    {{ cast_to_boolean('saturday') }} as saturday,
    {{ cast_to_boolean('thursday') }} as thursday,
    {{ cast_to_boolean('wednesday') }} as wednesday,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_rss_opts_schedule_daily_send_ab1') }}
-- daily_send at campaigns/rss_opts/schedule/daily_send
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

