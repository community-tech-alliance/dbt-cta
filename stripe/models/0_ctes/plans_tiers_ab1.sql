{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('plans') }}
{{ unnest_cte(ref('plans'), 'plans', 'tiers') }}
select
    _airbyte_plans_hashid,
    {{ json_extract_scalar(unnested_column_value('tiers'), ['up_to'], ['up_to']) }} as up_to,
    {{ json_extract_scalar(unnested_column_value('tiers'), ['flat_amount'], ['flat_amount']) }} as flat_amount,
    {{ json_extract_scalar(unnested_column_value('tiers'), ['unit_amount'], ['unit_amount']) }} as unit_amount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('plans') }} as table_alias
-- tiers at plans/tiers
{{ cross_join_unnest('plans', 'tiers') }}
where 1 = 1
and tiers is not null
{{ incremental_clause('_airbyte_emitted_at') }}

