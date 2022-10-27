{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_card_three_d_secure_ab3') }}
select
    _airbyte_card_hashid,
    version,
    succeeded,
    authenticated,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_three_d_secure_hashid
from {{ ref('charges_payment_method_details_card_three_d_secure_ab3') }}
-- three_d_secure at charges/payment_method_details/card/three_d_secure from {{ ref('charges_payment_method_details_card') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

