{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('stripe_partner_a', '_airbyte_raw_plans') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_string_array('_airbyte_data', ['tiers'], ['tiers']) }} as tiers,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['product'], ['product']) }} as product,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['interval'], ['interval']) }} as {{ adapter.quote('interval') }},
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['nickname'], ['nickname']) }} as nickname,
    {{ json_extract_scalar('_airbyte_data', ['tiers_mode'], ['tiers_mode']) }} as tiers_mode,
    {{ json_extract_scalar('_airbyte_data', ['usage_type'], ['usage_type']) }} as usage_type,
    {{ json_extract_scalar('_airbyte_data', ['billing_scheme'], ['billing_scheme']) }} as billing_scheme,
    {{ json_extract_scalar('_airbyte_data', ['interval_count'], ['interval_count']) }} as interval_count,
    {{ json_extract_scalar('_airbyte_data', ['aggregate_usage'], ['aggregate_usage']) }} as aggregate_usage,
    {{ json_extract_scalar('_airbyte_data', ['transform_usage'], ['transform_usage']) }} as transform_usage,
    {{ json_extract_scalar('_airbyte_data', ['trial_period_days'], ['trial_period_days']) }} as trial_period_days,
    {{ json_extract_scalar('_airbyte_data', ['statement_descriptor'], ['statement_descriptor']) }} as statement_descriptor,
    {{ json_extract_scalar('_airbyte_data', ['statement_description'], ['statement_description']) }} as statement_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('stripe_partner_a', '_airbyte_raw_plans') }} as table_alias
-- plans
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

