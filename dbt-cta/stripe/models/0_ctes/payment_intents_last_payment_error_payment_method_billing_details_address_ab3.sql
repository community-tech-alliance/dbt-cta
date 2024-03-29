{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_billing_details_address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_billing_details_hashid',
        'city',
        'line1',
        'line2',
        'state',
        'country',
        'postal_code',
    ]) }} as _airbyte_address_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_billing_details_address_ab2') }} as tmp
-- address at payment_intents_base/last_payment_error/payment_method/billing_details/address
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

