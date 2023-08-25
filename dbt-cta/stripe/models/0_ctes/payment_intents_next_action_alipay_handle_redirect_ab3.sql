{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_next_action_alipay_handle_redirect_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_next_action_hashid',
        'url',
        'native_url',
        'return_url',
        'native_data',
    ]) }} as _airbyte_alipay_handle_redirect_hashid,
    tmp.*
from {{ ref('payment_intents_next_action_alipay_handle_redirect_ab2') }} as tmp
-- alipay_handle_redirect at payment_intents_base/next_action/alipay_handle_redirect
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

