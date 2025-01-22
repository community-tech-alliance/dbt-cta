{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('bill_payments_base') }}
select
    _airbyte_bill_payments_hashid,
    {{ json_extract_scalar('CheckPayment', ['PrintStatus'], ['PrintStatus']) }} as PrintStatus,
    {{ json_extract('table_alias', 'CheckPayment', ['BankAccountRef'], ['BankAccountRef']) }} as BankAccountRef,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bill_payments_base') }} as table_alias
-- CheckPayment at bill_payments/CheckPayment
where
    1 = 1
    and CheckPayment is not null
