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
    {{ json_extract_scalar('tracking', ['opens'], ['opens']) }} as opens,
    {{ json_extract('table_alias', 'tracking', ['capsule'], ['capsule']) }} as capsule,
    {{ json_extract_scalar('tracking', ['ecomm360'], ['ecomm360']) }} as ecomm360,
    {{ json_extract_scalar('tracking', ['clicktale'], ['clicktale']) }} as clicktale,
    {{ json_extract('table_alias', 'tracking', ['salesforce'], ['salesforce']) }} as salesforce,
    {{ json_extract_scalar('tracking', ['html_clicks'], ['html_clicks']) }} as html_clicks,
    {{ json_extract_scalar('tracking', ['text_clicks'], ['text_clicks']) }} as text_clicks,
    {{ json_extract_scalar('tracking', ['goal_tracking'], ['goal_tracking']) }} as goal_tracking,
    {{ json_extract_scalar('tracking', ['google_analytics'], ['google_analytics']) }} as google_analytics,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_scd') }} as table_alias
-- tracking at campaigns/tracking
where 1 = 1
and tracking is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

