{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('recurring_donations_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_recurring_donations_hashid
from {{ ref('recurring_donations_ab3') }}
-- recurring_donations from {{ source('cta', '_airbyte_raw_recurring_donations') }}
where 1 = 1

