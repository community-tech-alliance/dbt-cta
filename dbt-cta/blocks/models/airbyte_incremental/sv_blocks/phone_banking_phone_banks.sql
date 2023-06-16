{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('phone_banking_phone_banks_scd') }}
select
    _airbyte_unique_key,
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
from {{ ref('phone_banking_phone_banks_scd') }}
-- phone_banking_phone_banks from {{ source('sv_blocks', '_airbyte_raw_phone_banking_phone_banks') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

