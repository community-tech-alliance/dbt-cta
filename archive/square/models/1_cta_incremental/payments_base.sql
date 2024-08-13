{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payments_ab3') }}
select
    id,
    note,
    status,
    order_id,
    created_at,
    refund_ids,
    updated_at,
    employee_id,
    location_id,
    receipt_url,
    source_type,
    total_money,
    amount_money,
    card_details,
    delay_action,
    delayed_until,
    version_token,
    approved_money,
    delay_duration,
    processing_fee,
    receipt_number,
    refunded_money,
    risk_evaluation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_payments_hashid
from {{ ref('payments_ab3') }}
-- payments from {{ source('cta', '_airbyte_raw_payments') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

