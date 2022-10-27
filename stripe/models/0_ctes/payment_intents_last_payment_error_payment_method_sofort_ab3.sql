{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_sofort_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_method_hashid',
        'country',
    ]) }} as _airbyte_sofort_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_sofort_ab2') }} tmp
-- sofort at payment_intents/last_payment_error/payment_method/sofort
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

