{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('subscriptions_items_ab3') }}
select
    _airbyte_subscriptions_hashid,
    url,
    data,
    object,
    has_more,
    total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_items_hashid
from {{ ref('subscriptions_items_ab3') }}
-- items at subscriptions_base/items from {{ ref('subscriptions_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

