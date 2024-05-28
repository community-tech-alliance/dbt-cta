{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('recurring_donations_ab4') }}
select
    id,
    status,
    values,
    user_id,
    created_at,
    updated_at,
    next_payment,
    failure_count,
    fundraising_id,
    recurring_period,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_recurring_donations_hashid
from {{ ref('recurring_donations_ab4') }}