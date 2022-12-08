{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('subscription_items_base') }}
select
    _airbyte_subscription_items_hashid,
    {{ json_extract_scalar('plan', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('plan', ['name'], ['name']) }} as name,
    {{ json_extract_string_array('plan', ['tiers'], ['tiers']) }} as tiers,
    {{ json_extract_scalar('plan', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('plan', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('plan', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('plan', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('plan', ['product'], ['product']) }} as product,
    {{ json_extract_scalar('plan', ['updated'], ['updated']) }} as updated,
    {{ json_extract_scalar('plan', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('plan', ['interval'], ['interval']) }} as {{ adapter.quote('interval') }},
    {{ json_extract_scalar('plan', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', 'plan', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('plan', ['nickname'], ['nickname']) }} as nickname,
    {{ json_extract_scalar('plan', ['tiers_mode'], ['tiers_mode']) }} as tiers_mode,
    {{ json_extract_scalar('plan', ['usage_type'], ['usage_type']) }} as usage_type,
    {{ json_extract_scalar('plan', ['billing_scheme'], ['billing_scheme']) }} as billing_scheme,
    {{ json_extract_scalar('plan', ['interval_count'], ['interval_count']) }} as interval_count,
    {{ json_extract_scalar('plan', ['aggregate_usage'], ['aggregate_usage']) }} as aggregate_usage,
    {{ json_extract_scalar('plan', ['transform_usage'], ['transform_usage']) }} as transform_usage,
    {{ json_extract_scalar('plan', ['trial_period_days'], ['trial_period_days']) }} as trial_period_days,
    {{ json_extract_scalar('plan', ['statement_descriptor'], ['statement_descriptor']) }} as statement_descriptor,
    {{ json_extract_scalar('plan', ['statement_description'], ['statement_description']) }} as statement_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('subscription_items_base') }} as table_alias
-- plan at subscription_items_base/plan
where 1 = 1
and plan is not null

