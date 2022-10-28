{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_total_details_breakdown_ab3') }}
select
    _airbyte_total_details_hashid,
    taxes,
    discounts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_breakdown_hashid
from {{ ref('checkout_sessions_total_details_breakdown_ab3') }}
-- breakdown at checkout_sessions/total_details/breakdown from {{ ref('checkout_sessions_total_details') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

