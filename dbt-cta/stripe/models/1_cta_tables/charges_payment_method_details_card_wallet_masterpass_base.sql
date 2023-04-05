{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_card_wallet_masterpass_ab3') }}
select
    _airbyte_wallet_hashid,
    name,
    email,
    billing_address,
    shipping_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_masterpass_hashid
from {{ ref('charges_payment_method_details_card_wallet_masterpass_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

