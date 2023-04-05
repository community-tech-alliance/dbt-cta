{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_payment_method_options_boleto_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_method_options_hashid',
        'expires_after_days',
    ]) }} as _airbyte_boleto_hashid,
    tmp.*
from {{ ref('checkout_sessions_payment_method_options_boleto_ab2') }} tmp
-- boleto at checkout_sessions_base/payment_method_options/boleto
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

