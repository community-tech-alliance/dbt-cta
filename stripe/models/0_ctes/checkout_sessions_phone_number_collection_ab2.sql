{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_phone_number_collection_ab1') }}
select
    _airbyte_checkout_sessions_hashid,
    {{ cast_to_boolean('enabled') }} as enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_phone_number_collection_ab1') }}
-- phone_number_collection at checkout_sessions/phone_number_collection
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

