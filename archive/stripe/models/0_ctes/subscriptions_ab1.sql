{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_subscriptions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract('table_alias', '_airbyte_data', ['plan'], ['plan']) }} as plan,
    {{ json_extract('table_alias', '_airbyte_data', ['items'], ['items']) }} as items,
    {{ json_extract_scalar('_airbyte_data', ['start'], ['start']) }} as start,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['billing'], ['billing']) }} as billing,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['customer'], ['customer']) }} as customer,
    {{ json_extract('table_alias', '_airbyte_data', ['discount'], ['discount']) }} as discount,
    {{ json_extract_scalar('_airbyte_data', ['ended_at'], ['ended_at']) }} as ended_at,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['quantity'], ['quantity']) }} as quantity,
    {{ json_extract_scalar('_airbyte_data', ['trial_end'], ['trial_end']) }} as trial_end,
    {{ json_extract_scalar('_airbyte_data', ['canceled_at'], ['canceled_at']) }} as canceled_at,
    {{ json_extract_scalar('_airbyte_data', ['tax_percent'], ['tax_percent']) }} as tax_percent,
    {{ json_extract_scalar('_airbyte_data', ['trial_start'], ['trial_start']) }} as trial_start,
    {{ json_extract_scalar('_airbyte_data', ['days_until_due'], ['days_until_due']) }} as days_until_due,
    {{ json_extract_scalar('_airbyte_data', ['current_period_end'], ['current_period_end']) }} as current_period_end,
    {{ json_extract_scalar('_airbyte_data', ['billing_cycle_anchor'], ['billing_cycle_anchor']) }} as billing_cycle_anchor,
    {{ json_extract_scalar('_airbyte_data', ['cancel_at_period_end'], ['cancel_at_period_end']) }} as cancel_at_period_end,
    {{ json_extract_scalar('_airbyte_data', ['current_period_start'], ['current_period_start']) }} as current_period_start,
    {{ json_extract_scalar('_airbyte_data', ['application_fee_percent'], ['application_fee_percent']) }} as application_fee_percent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_subscriptions') }} as table_alias
-- subscriptions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

