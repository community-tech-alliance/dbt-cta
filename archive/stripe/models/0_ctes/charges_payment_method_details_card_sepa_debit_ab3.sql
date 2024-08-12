{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_sepa_debit_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_hashid',
        'last4',
        'country',
        'mandate',
        'bank_code',
        'branch_code',
        'fingerprint',
    ]) }} as _airbyte_sepa_debit_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_sepa_debit_ab2') }} as tmp
-- sepa_debit at charges_base/payment_method_details/card/sepa_debit
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

