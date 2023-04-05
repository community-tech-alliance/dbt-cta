{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_card_present_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_hashid',
        'brand',
        'last4',
        'country',
        'funding',
        'network',
        object_to_string('receipt'),
        'exp_year',
        'exp_month',
        'fingerprint',
        'read_method',
        'emv_auth_data',
        'generated_card',
    ]) }} as _airbyte_card_present_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_card_present_ab2') }} tmp
-- card_present at charges_base/payment_method_details/card/card_present
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

