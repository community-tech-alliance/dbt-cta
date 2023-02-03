{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('donations_recurring_donations_ab3') }}
select
    id,
    created_at,
    updated_at,
    donation_id,
    recurring_donation_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_donations_recurring_donations_hashid
from {{ ref('donations_recurring_donations_ab3') }}
-- donations_recurring_donations from {{ source('cta', '_airbyte_raw_donations_recurring_donations') }}
where 1 = 1

