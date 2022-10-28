{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_ach_debit_ab3') }}
select
    _airbyte_payment_method_details_hashid,
    last4,
    country,
    bank_name,
    fingerprint,
    routing_number,
    account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ach_debit_hashid
from {{ ref('charges_payment_method_details_ach_debit_ab3') }}
-- ach_debit at charges_base/payment_method_details/ach_debit from {{ ref('charges_payment_method_details') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

