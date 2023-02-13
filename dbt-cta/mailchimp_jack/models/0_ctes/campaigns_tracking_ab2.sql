{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_tracking_ab1') }}
select
    _airbyte_campaigns_hashid,
    {{ cast_to_boolean('opens') }} as opens,
    cast(capsule as {{ type_json() }}) as capsule,
    {{ cast_to_boolean('ecomm360') }} as ecomm360,
    cast(clicktale as {{ dbt_utils.type_string() }}) as clicktale,
    cast(salesforce as {{ type_json() }}) as salesforce,
    {{ cast_to_boolean('html_clicks') }} as html_clicks,
    {{ cast_to_boolean('text_clicks') }} as text_clicks,
    {{ cast_to_boolean('goal_tracking') }} as goal_tracking,
    cast(google_analytics as {{ dbt_utils.type_string() }}) as google_analytics,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_tracking_ab1') }}
-- tracking at campaigns/tracking
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

