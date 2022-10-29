{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_next_action') }}
select
    _airbyte_next_action_hashid,
    {{ json_extract_scalar('verify_with_microdeposits', ['arrival_date'], ['arrival_date']) }} as arrival_date,
    {{ json_extract_scalar('verify_with_microdeposits', ['hosted_verification_url'], ['hosted_verification_url']) }} as hosted_verification_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_next_action') }} as table_alias
-- verify_with_microdeposits at payment_intents_base/next_action/verify_with_microdeposits
where 1 = 1
and verify_with_microdeposits is not null
{{ incremental_clause('_airbyte_emitted_at') }}

