{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_phone_number_collection_ab3') }}
select
    _airbyte_checkout_sessions_hashid,
    enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_number_collection_hashid
from {{ ref('checkout_sessions_phone_number_collection_ab3') }}
-- phone_number_collection at checkout_sessions/phone_number_collection from {{ ref('checkout_sessions') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

