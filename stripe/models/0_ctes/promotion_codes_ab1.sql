{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_promotion_codes') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract('table_alias', '_airbyte_data', ['coupon'], ['coupon']) }} as coupon,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['expires_at'], ['expires_at']) }} as expires_at,
    {{ json_extract('table_alias', '_airbyte_data', ['restrictions'], ['restrictions']) }} as restrictions,
    {{ json_extract_scalar('_airbyte_data', ['max_redemptions'], ['max_redemptions']) }} as max_redemptions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_promotion_codes') }} as table_alias
-- promotion_codes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

