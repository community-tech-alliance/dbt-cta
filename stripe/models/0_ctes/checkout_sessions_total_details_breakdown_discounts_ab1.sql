{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_total_details_breakdown_base') }}
{{ unnest_cte(ref('checkout_sessions_total_details_breakdown_base'), 'breakdown', 'discounts') }}
select
    _airbyte_breakdown_hashid,
    {{ json_extract_scalar(unnested_column_value('discounts'), ['amount'], ['amount']) }} as amount,
    {{ json_extract('', unnested_column_value('discounts'), ['discount'], ['discount']) }} as discount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_total_details_breakdown_base') }} as table_alias
-- discounts at checkout_sessions_base/total_details/breakdown/discounts
{{ cross_join_unnest('breakdown', 'discounts') }}
where 1 = 1
and discounts is not null
{{ incremental_clause('_airbyte_emitted_at') }}

