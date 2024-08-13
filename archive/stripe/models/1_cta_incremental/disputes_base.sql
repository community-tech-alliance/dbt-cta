{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_disputes_hashid',
    
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('disputes_ab3') }}
select
    id,
    amount,
    charge,
    object,
    reason,
    status,
    created,
    currency,
    evidence,
    livemode,
    metadata,
    evidence_details,
    balance_transactions,
    is_charge_refundable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_disputes_hashid
from {{ ref('disputes_ab3') }}
-- disputes from {{ source('cta', '_airbyte_raw_disputes') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

