{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_report_summary_ab1') }}
select
    _airbyte_campaigns_hashid,
    cast(opens as {{ dbt_utils.type_bigint() }}) as opens,
    cast(clicks as {{ dbt_utils.type_bigint() }}) as clicks,
    cast(ecommerce as {{ type_json() }}) as ecommerce,
    cast(open_rate as {{ dbt_utils.type_float() }}) as open_rate,
    cast(click_rate as {{ dbt_utils.type_float() }}) as click_rate,
    cast(unique_opens as {{ dbt_utils.type_bigint() }}) as unique_opens,
    cast(subscriber_clicks as {{ dbt_utils.type_bigint() }}) as subscriber_clicks,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_report_summary_ab1') }}
-- report_summary at campaigns/report_summary
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

