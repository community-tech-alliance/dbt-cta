{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('bill_payments_CreditCardPayment_base') }}
select
    _airbyte_CreditCardPayment_hashid,
    {{ json_extract_scalar('CCAccountRef', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('CCAccountRef', ['value'], ['value']) }} as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bill_payments_CreditCardPayment_base') }}
-- CCAccountRef at bill_payments/CreditCardPayment/CCAccountRef
where
    1 = 1
    and CCAccountRef is not null
