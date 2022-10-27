{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_next_action_redirect_to_url_ab3') }}
select
    _airbyte_next_action_hashid,
    url,
    return_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_redirect_to_url_hashid
from {{ ref('payment_intents_next_action_redirect_to_url_ab3') }}
-- redirect_to_url at payment_intents/next_action/redirect_to_url from {{ ref('payment_intents_next_action') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

