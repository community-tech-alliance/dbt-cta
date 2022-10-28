{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_after_expiration') }}
select
    _airbyte_after_expiration_hashid,
    {{ json_extract_scalar('recovery', ['url'], ['url']) }} as url,
    {{ json_extract_scalar('recovery', ['enabled'], ['enabled']) }} as enabled,
    {{ json_extract_scalar('recovery', ['expires_at'], ['expires_at']) }} as expires_at,
    {{ json_extract_scalar('recovery', ['allow_promotion_codes'], ['allow_promotion_codes']) }} as allow_promotion_codes,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_after_expiration') }} as table_alias
-- recovery at checkout_sessions/after_expiration/recovery
where 1 = 1
and recovery is not null
{{ incremental_clause('_airbyte_emitted_at') }}

