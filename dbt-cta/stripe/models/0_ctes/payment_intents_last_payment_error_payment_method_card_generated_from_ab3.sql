{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_hashid',
        'charge',
        'setup_attempt',
        object_to_string('payment_method_details'),
    ]) }} as _airbyte_generated_from_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_ab2') }} as tmp
-- generated_from at payment_intents_base/last_payment_error/payment_method/card/generated_from
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

