{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('refunds_ab3') }}
select
    id,
    reason,
    status,
    order_id,
    created_at,
    payment_id,
    updated_at,
    location_id,
    amount_money,
    processing_fee,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_refunds_hashid
from {{ ref('refunds_ab3') }}
-- refunds from {{ source('cta', '_airbyte_raw_refunds') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

