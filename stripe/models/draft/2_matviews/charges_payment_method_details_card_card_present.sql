{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_card_card_present_ab3') }}
select
    _airbyte_card_hashid,
    brand,
    last4,
    country,
    funding,
    network,
    receipt,
    exp_year,
    exp_month,
    fingerprint,
    read_method,
    emv_auth_data,
    generated_card,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_card_present_hashid
from {{ ref('charges_payment_method_details_card_card_present_ab3') }}
-- card_present at charges_base/payment_method_details/card/card_present from {{ ref('charges_payment_method_details_card') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

