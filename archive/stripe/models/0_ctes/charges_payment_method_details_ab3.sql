{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_charges_hashid',
        object_to_string('card'),
        'type',
        object_to_string('alipay'),
        object_to_string('ach_debit'),
        object_to_string('bancontact'),
        object_to_string('ach_credit_transfer'),
    ]) }} as _airbyte_payment_method_details_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_ab2') }} as tmp
-- payment_method_details at charges_base/payment_method_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

