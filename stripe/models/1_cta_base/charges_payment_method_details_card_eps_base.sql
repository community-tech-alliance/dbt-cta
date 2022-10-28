{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_card_eps_ab3') }}
select
    _airbyte_card_hashid,
    verified_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_eps_hashid
from {{ ref('charges_payment_method_details_card_eps_ab3') }}
-- eps at charges/payment_method_details/card/eps from {{ ref('charges_payment_method_details_card') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

