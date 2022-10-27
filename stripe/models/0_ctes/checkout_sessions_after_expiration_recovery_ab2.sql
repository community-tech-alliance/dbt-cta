{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_after_expiration_recovery_ab1') }}
select
    _airbyte_after_expiration_hashid,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    {{ cast_to_boolean('enabled') }} as enabled,
    cast(expires_at as {{ dbt_utils.type_bigint() }}) as expires_at,
    {{ cast_to_boolean('allow_promotion_codes') }} as allow_promotion_codes,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_after_expiration_recovery_ab1') }}
-- recovery at checkout_sessions/after_expiration/recovery
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

