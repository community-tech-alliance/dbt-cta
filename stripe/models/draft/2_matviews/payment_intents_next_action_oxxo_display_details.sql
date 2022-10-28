{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_next_action_oxxo_display_details_ab3') }}
select
    _airbyte_next_action_hashid,
    number,
    expires_after,
    hosted_voucher_url,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_oxxo_display_details_hashid
from {{ ref('payment_intents_next_action_oxxo_display_details_ab3') }}
-- oxxo_display_details at payment_intents/next_action/oxxo_display_details from {{ ref('payment_intents_next_action') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

