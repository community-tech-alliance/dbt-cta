{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_ach_debit_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_method_details_hashid',
        'last4',
        'country',
        'bank_name',
        'fingerprint',
        'routing_number',
        'account_holder_type',
    ]) }} as _airbyte_ach_debit_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_ach_debit_ab2') }} tmp
-- ach_debit at charges_base/payment_method_details/ach_debit
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

