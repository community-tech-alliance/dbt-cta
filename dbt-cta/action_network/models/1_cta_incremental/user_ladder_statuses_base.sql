{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_ladder_statuses_ab4') }}
select
    id,
    rung_id,
    step_id,
    user_id,
    ladder_id,
    wait_time,
    created_at,
    extra_data,
    updated_at,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_ladder_statuses_hashid
from {{ ref('user_ladder_statuses_ab4') }}
