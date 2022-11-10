{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_ach_credit_transfer_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_method_details_hashid',
        'bank_name',
        'swift_code',
        'account_number',
        'routing_number',
    ]) }} as _airbyte_ach_credit_transfer_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_ach_credit_transfer_ab2') }} tmp
-- ach_credit_transfer at charges_base/payment_method_details/ach_credit_transfer
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

