{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_charges_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_intents_hashid',
        'url',
        array_to_string('data'),
        'object',
        boolean_to_string('has_more'),
        'total_count',
    ]) }} as _airbyte_charges_hashid,
    tmp.*
from {{ ref('payment_intents_charges_ab2') }} tmp
-- charges at payment_intents/charges
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

