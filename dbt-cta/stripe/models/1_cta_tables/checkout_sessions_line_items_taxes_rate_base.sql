{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_line_items_taxes_rate_ab3') }}
select
    _airbyte_taxes_hashid,
    id,
    state,
    active,
    object,
    country,
    created,
    livemode,
    metadata,
    tax_type,
    inclusive,
    percentage,
    description,
    display_name,
    jurisdiction,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_rate_hashid
from {{ ref('checkout_sessions_line_items_taxes_rate_ab3') }}
-- rate at checkout_sessions_line_items/taxes/rate from {{ ref('checkout_sessions_line_items_taxes_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

