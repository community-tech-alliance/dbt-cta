{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_payment_method_hashid',
        'brand',
        'last4',
        object_to_string('checks'),
        object_to_string('wallet'),
        'country',
        'funding',
        'exp_year',
        object_to_string('networks'),
        'exp_month',
        'fingerprint',
        object_to_string('generated_from'),
        object_to_string('three_d_secure_usage'),
    ]) }} as _airbyte_card_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_card_ab2') }} as tmp
-- card at payment_intents_base/last_payment_error/payment_method/card
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

