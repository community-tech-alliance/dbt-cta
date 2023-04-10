{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_next_action_oxxo_display_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_next_action_hashid',
        'number',
        'expires_after',
        'hosted_voucher_url',
    ]) }} as _airbyte_oxxo_display_details_hashid,
    tmp.*
from {{ ref('payment_intents_next_action_oxxo_display_details_ab2') }} tmp
-- oxxo_display_details at payment_intents_base/next_action/oxxo_display_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

