{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_coupons') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['valid'], ['valid']) }} as valid,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['duration'], ['duration']) }} as duration,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['redeem_by'], ['redeem_by']) }} as redeem_by,
    {{ json_extract_scalar('_airbyte_data', ['amount_off'], ['amount_off']) }} as amount_off,
    {{ json_extract_scalar('_airbyte_data', ['percent_off'], ['percent_off']) }} as percent_off,
    {{ json_extract_scalar('_airbyte_data', ['times_redeemed'], ['times_redeemed']) }} as times_redeemed,
    {{ json_extract_scalar('_airbyte_data', ['max_redemptions'], ['max_redemptions']) }} as max_redemptions,
    {{ json_extract_scalar('_airbyte_data', ['duration_in_months'], ['duration_in_months']) }} as duration_in_months,
    {{ json_extract_scalar('_airbyte_data', ['percent_off_precise'], ['percent_off_precise']) }} as percent_off_precise,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_coupons') }} as table_alias
-- coupons
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

