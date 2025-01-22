{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('bill_payments_CheckPayment_ab1') }}
select
    _airbyte_bill_payments_hashid,
    cast(PrintStatus as {{ dbt_utils.type_string() }}) as PrintStatus,
    cast(BankAccountRef as {{ type_json() }}) as BankAccountRef,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bill_payments_CheckPayment_ab1') }}
-- CheckPayment at bill_payments/CheckPayment
where 1 = 1
