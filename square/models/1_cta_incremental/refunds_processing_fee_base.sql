{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('refunds_processing_fee_ab3') }}
select
    _airbyte_refunds_hashid,
    type,
    amount_money,
    effective_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_processing_fee_hashid
from {{ ref('refunds_processing_fee_ab3') }}
-- processing_fee at refunds/processing_fee from {{ ref('refunds') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

