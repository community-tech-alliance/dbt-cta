{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('subscriptions_discount_base') }}
select
    _airbyte_discount_hashid,
    {{ json_extract_scalar('coupon', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('coupon', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('coupon', ['valid'], ['valid']) }} as valid,
    {{ json_extract_scalar('coupon', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('coupon', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('coupon', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('coupon', ['duration'], ['duration']) }} as duration,
    {{ json_extract_scalar('coupon', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', 'coupon', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('coupon', ['redeem_by'], ['redeem_by']) }} as redeem_by,
    {{ json_extract_scalar('coupon', ['amount_off'], ['amount_off']) }} as amount_off,
    {{ json_extract_scalar('coupon', ['percent_off'], ['percent_off']) }} as percent_off,
    {{ json_extract_scalar('coupon', ['times_redeemed'], ['times_redeemed']) }} as times_redeemed,
    {{ json_extract_scalar('coupon', ['max_redemptions'], ['max_redemptions']) }} as max_redemptions,
    {{ json_extract_scalar('coupon', ['duration_in_months'], ['duration_in_months']) }} as duration_in_months,
    {{ json_extract_scalar('coupon', ['percent_off_precise'], ['percent_off_precise']) }} as percent_off_precise,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('subscriptions_discount_base') }} as table_alias
-- coupon at subscriptions_base/discount/coupon
where
    1 = 1
    and coupon is not null
{{ incremental_clause('_airbyte_emitted_at') }}

