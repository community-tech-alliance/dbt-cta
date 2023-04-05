{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_line_items_price_transform_quantity_ab3') }}
select
    _airbyte_price_hashid,
    round,
    divide_by,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_transform_quantity_hashid
from {{ ref('checkout_sessions_line_items_price_transform_quantity_ab3') }}
-- transform_quantity at checkout_sessions_line_items/price/transform_quantity from {{ ref('checkout_sessions_line_items_price_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

