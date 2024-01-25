{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('phone_banking_phone_banks_ab4') }}
select
    end_date,
    daily_end_time,
    min_call_delay_in_hours,
    list_id,
    extras,
    created_at,
    description,
    script_id,
    created_by_user_id,
    archived,
    updated_at,
    turf_id,
    name,
    closed,
    id,
    current_round,
    call_type,
    daily_start_time,
    number_of_rounds,
    start_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_banking_phone_banks_hashid
from {{ ref('phone_banking_phone_banks_ab4') }}
-- phone_banking_phone_banks from {{ source('cta', '_airbyte_raw_phone_banking_phone_banks') }}
