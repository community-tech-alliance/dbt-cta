{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('bill_payments_CreditCardPayment_ab1') }}
select
    _airbyte_bill_payments_hashid,
    cast(CCAccountRef as {{ type_json() }}) as CCAccountRef,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bill_payments_CreditCardPayment_ab1') }}
-- CreditCardPayment at bill_payments/CreditCardPayment
where 1 = 1
