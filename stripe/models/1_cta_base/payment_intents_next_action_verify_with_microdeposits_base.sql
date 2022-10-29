{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_next_action_verify_with_microdeposits_ab3') }}
select
    _airbyte_next_action_hashid,
    arrival_date,
    hosted_verification_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_verify_with_microdeposits_hashid
from {{ ref('payment_intents_next_action_verify_with_microdeposits_ab3') }}
-- verify_with_microdeposits at payment_intents_base/next_action/verify_with_microdeposits from {{ ref('payment_intents_next_action_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

