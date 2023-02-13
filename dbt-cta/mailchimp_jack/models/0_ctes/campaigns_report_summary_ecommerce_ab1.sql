{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns_report_summary') }}
select
    _airbyte_report_summary_hashid,
    {{ json_extract_scalar('ecommerce', ['total_spent'], ['total_spent']) }} as total_spent,
    {{ json_extract_scalar('ecommerce', ['total_orders'], ['total_orders']) }} as total_orders,
    {{ json_extract_scalar('ecommerce', ['total_revenue'], ['total_revenue']) }} as total_revenue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_report_summary') }} as table_alias
-- ecommerce at campaigns/report_summary/ecommerce
where 1 = 1
and ecommerce is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

