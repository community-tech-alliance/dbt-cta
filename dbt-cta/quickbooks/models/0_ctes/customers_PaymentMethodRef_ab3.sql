{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_PaymentMethodRef_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_customers_hashid',
        'name',
        'value',
    ]) }} as _airbyte_PaymentMethodRef_hashid,
    tmp.*
from {{ ref('customers_PaymentMethodRef_ab2') }} tmp
-- PaymentMethodRef at customers/PaymentMethodRef
where 1 = 1

