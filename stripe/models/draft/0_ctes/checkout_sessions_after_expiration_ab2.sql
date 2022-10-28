{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_after_expiration_ab1') }}
select
    _airbyte_checkout_sessions_hashid,
    cast(recovery as {{ type_json() }}) as recovery,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_after_expiration_ab1') }}
-- after_expiration at checkout_sessions/after_expiration
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

