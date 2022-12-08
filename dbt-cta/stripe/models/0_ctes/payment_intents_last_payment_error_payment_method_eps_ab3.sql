{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_eps_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_method_hashid',
        'bank',
    ]) }} as _airbyte_eps_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_eps_ab2') }} tmp
-- eps at payment_intents_base/last_payment_error/payment_method/eps
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

