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
    {{ json_extract_scalar('report_summary', ['opens'], ['opens']) }} as opens,
    {{ json_extract_scalar('report_summary', ['clicks'], ['clicks']) }} as clicks,
    {{ json_extract('table_alias', 'report_summary', ['ecommerce'], ['ecommerce']) }} as ecommerce,
    {{ json_extract_scalar('report_summary', ['open_rate'], ['open_rate']) }} as open_rate,
    {{ json_extract_scalar('report_summary', ['click_rate'], ['click_rate']) }} as click_rate,
    {{ json_extract_scalar('report_summary', ['unique_opens'], ['unique_opens']) }} as unique_opens,
    {{ json_extract_scalar('report_summary', ['subscriber_clicks'], ['subscriber_clicks']) }} as subscriber_clicks,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_scd') }} as table_alias
-- report_summary at campaigns/report_summary
where 1 = 1
and report_summary is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

