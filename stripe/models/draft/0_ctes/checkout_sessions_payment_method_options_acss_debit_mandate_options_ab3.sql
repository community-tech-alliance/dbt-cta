{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_payment_method_options_acss_debit_mandate_options_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_acss_debit_hashid',
        array_to_string('default_for'),
        'payment_schedule',
        'transaction_type',
        'custom_mandate_url',
        'interval_description',
    ]) }} as _airbyte_mandate_options_hashid,
    tmp.*
from {{ ref('checkout_sessions_payment_method_options_acss_debit_mandate_options_ab2') }} tmp
-- mandate_options at checkout_sessions/payment_method_options/acss_debit/mandate_options
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

