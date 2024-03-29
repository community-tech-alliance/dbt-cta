{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_intents_hashid',
        'code',
        'type',
        'param',
        'charge',
        'doc_url',
        'message',
        'decline_code',
        object_to_string('payment_method'),
        'payment_method_type',
    ]) }} as _airbyte_last_payment_error_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_ab2') }} as tmp
-- last_payment_error at payment_intents_base/last_payment_error
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

