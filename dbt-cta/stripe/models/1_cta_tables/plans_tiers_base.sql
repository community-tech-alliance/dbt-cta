{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('plans_tiers_ab3') }}
select
    _airbyte_plans_hashid,
    up_to,
    flat_amount,
    unit_amount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tiers_hashid
from {{ ref('plans_tiers_ab3') }}
-- tiers at plans_base/tiers from {{ ref('plans_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

