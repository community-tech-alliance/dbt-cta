{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_rss_opts_schedule_ab1') }}
select
    _airbyte_rss_opts_hashid,
    cast(hour as {{ dbt_utils.type_bigint() }}) as hour,
    cast(daily_send as {{ type_json() }}) as daily_send,
    cast(weekly_send_day as {{ dbt_utils.type_string() }}) as weekly_send_day,
    cast(monthly_send_date as {{ dbt_utils.type_float() }}) as monthly_send_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_rss_opts_schedule_ab1') }}
-- schedule at campaigns/rss_opts/schedule
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

