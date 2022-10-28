{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_payment_method_options_acss_debit_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_method_options_hashid',
        'currency',
        object_to_string('mandate_options'),
        'verification_method',
    ]) }} as _airbyte_acss_debit_hashid,
    tmp.*
from {{ ref('checkout_sessions_payment_method_options_acss_debit_ab2') }} tmp
-- acss_debit at checkout_sessions/payment_method_options/acss_debit
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

