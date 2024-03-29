{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_fpx_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_method_hashid',
        'bank',
    ]) }} as _airbyte_fpx_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_fpx_ab2') }} as tmp
-- fpx at payment_intents_base/last_payment_error/payment_method/fpx
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

