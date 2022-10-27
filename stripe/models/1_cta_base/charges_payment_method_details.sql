{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_ab3') }}
select
    _airbyte_charges_hashid,
    card,
    type,
    alipay,
    ach_debit,
    bancontact,
    ach_credit_transfer,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_payment_method_details_hashid
from {{ ref('charges_payment_method_details_ab3') }}
-- payment_method_details at charges/payment_method_details from {{ ref('charges') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

