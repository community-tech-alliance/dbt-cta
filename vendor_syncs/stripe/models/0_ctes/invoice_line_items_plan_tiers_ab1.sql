{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('invoice_line_items_plan_base') }}
{{ unnest_cte(ref('invoice_line_items_plan_base'), 'plan', 'tiers') }}
select
    _airbyte_plan_hashid,
    {{ json_extract_scalar(unnested_column_value('tiers'), ['up_to'], ['up_to']) }} as up_to,
    {{ json_extract_scalar(unnested_column_value('tiers'), ['flat_amount'], ['flat_amount']) }} as flat_amount,
    {{ json_extract_scalar(unnested_column_value('tiers'), ['unit_amount'], ['unit_amount']) }} as unit_amount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoice_line_items_plan_base') }} as table_alias
-- tiers at invoice_line_items_base/plan/tiers
{{ cross_join_unnest('plan', 'tiers') }}
where 1 = 1
and tiers is not null

