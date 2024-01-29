{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_next_action_boleto_display_details_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_next_action_hashid',
        'pdf',
        'number',
        'expires_at',
        'hosted_voucher_url',
    ]) }} as _airbyte_boleto_display_details_hashid,
    tmp.*
from {{ ref('payment_intents_next_action_boleto_display_details_ab2') }} as tmp
-- boleto_display_details at payment_intents_base/next_action/boleto_display_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

