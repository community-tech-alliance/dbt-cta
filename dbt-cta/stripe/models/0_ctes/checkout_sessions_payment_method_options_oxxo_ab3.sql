{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_payment_method_options_oxxo_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_payment_method_options_hashid',
        'expires_after_days',
    ]) }} as _airbyte_oxxo_hashid,
    tmp.*
from {{ ref('checkout_sessions_payment_method_options_oxxo_ab2') }} as tmp
-- oxxo at checkout_sessions_base/payment_method_options/oxxo
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

