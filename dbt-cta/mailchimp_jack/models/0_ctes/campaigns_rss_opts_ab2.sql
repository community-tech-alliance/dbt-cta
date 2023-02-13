{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_rss_opts_ab1') }}
select
    _airbyte_campaigns_hashid,
    cast(feed_url as {{ dbt_utils.type_string() }}) as feed_url,
    cast(schedule as {{ type_json() }}) as schedule,
    cast(frequency as {{ dbt_utils.type_string() }}) as frequency,
    cast(last_sent as {{ dbt_utils.type_string() }}) as last_sent,
    {{ cast_to_boolean('constrain_rss_img') }} as constrain_rss_img,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_rss_opts_ab1') }}
-- rss_opts at campaigns/rss_opts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

