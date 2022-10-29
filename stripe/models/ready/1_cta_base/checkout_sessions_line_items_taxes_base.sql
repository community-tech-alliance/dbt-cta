{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_line_items_taxes_ab3') }}
select
    _airbyte_checkout_sessions_line_items_hashid,
    rate,
    amount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_taxes_hashid
from {{ ref('checkout_sessions_line_items_taxes_ab3') }}
-- taxes at checkout_sessions_line_items/taxes from {{ ref('checkout_sessions_line_items_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

