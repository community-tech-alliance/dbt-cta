{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_total_details_breakdown_taxes_ab3') }}
select
    _airbyte_breakdown_hashid,
    rate,
    amount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_taxes_hashid
from {{ ref('checkout_sessions_total_details_breakdown_taxes_ab3') }}
-- taxes at checkout_sessions_base/total_details/breakdown/taxes from {{ ref('checkout_sessions_total_details_breakdown_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

