{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_shipping_address_collection_ab3') }}
select
    _airbyte_checkout_sessions_hashid,
    allowed_countries,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_shipping_address_collection_hashid
from {{ ref('checkout_sessions_shipping_address_collection_ab3') }}
-- shipping_address_collection at checkout_sessions_base/shipping_address_collection from {{ ref('checkout_sessions_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}
