{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_payment_method_details_ach_credit_transfer_ab3') }}
select
    _airbyte_payment_method_details_hashid,
    bank_name,
    swift_code,
    account_number,
    routing_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ach_credit_transfer_hashid
from {{ ref('charges_payment_method_details_ach_credit_transfer_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

