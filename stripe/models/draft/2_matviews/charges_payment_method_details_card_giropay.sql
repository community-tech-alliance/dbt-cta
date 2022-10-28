{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_card_giropay_ab3') }}
select
    _airbyte_card_hashid,
    bic,
    bank_code,
    bank_name,
    verified_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_giropay_hashid
from {{ ref('charges_payment_method_details_card_giropay_ab3') }}
-- giropay at charges_base/payment_method_details/card/giropay from {{ ref('charges_payment_method_details_card_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

