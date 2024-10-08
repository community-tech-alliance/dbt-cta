{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('check_ins_ab3') }}
select
    end_date,
    updated_at,
    turf_id,
    created_at,
    days_of_the_week,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_check_ins_hashid
from {{ ref('check_ins_ab3') }}
-- check_ins from {{ source('cta', '_airbyte_raw_check_ins') }}
