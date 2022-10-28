{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_card_checks_ab3') }}
select
    _airbyte_card_hashid,
    cvc_check,
    address_line1_check,
    address_postal_code_check,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_checks_hashid
from {{ ref('charges_payment_method_details_card_checks_ab3') }}
-- checks at charges/payment_method_details/card/checks from {{ ref('charges_payment_method_details_card') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

