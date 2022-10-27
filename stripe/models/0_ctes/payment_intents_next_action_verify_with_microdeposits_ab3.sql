{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_next_action_verify_with_microdeposits_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_next_action_hashid',
        'arrival_date',
        'hosted_verification_url',
    ]) }} as _airbyte_verify_with_microdeposits_hashid,
    tmp.*
from {{ ref('payment_intents_next_action_verify_with_microdeposits_ab2') }} tmp
-- verify_with_microdeposits at payment_intents/next_action/verify_with_microdeposits
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

