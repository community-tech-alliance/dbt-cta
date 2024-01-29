{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bill_payments_Line_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_bill_payments_hashid',
        'Amount',
        array_to_string('LinkedTxn'),
    ]) }} as _airbyte_Line_hashid,
    tmp.*
from {{ ref('bill_payments_Line_ab2') }} tmp
-- Line at bill_payments/Line
where 1 = 1

