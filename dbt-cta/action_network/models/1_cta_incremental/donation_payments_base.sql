{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('donation_payments_ab4') }}
select
    id,
    tip,
    name,
    error,
    amount,
    user_id,
    group_id,
    wepay_id,
    recurring,
    created_at,
    error_code,
    updated_at,
    donation_id,
    wepay_status,
    error_message,
    fundraising_id,
    transaction_id,
    donation_user_id,
    recurring_period,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_donation_payments_hashid
from {{ ref('donation_payments_ab4') }}
