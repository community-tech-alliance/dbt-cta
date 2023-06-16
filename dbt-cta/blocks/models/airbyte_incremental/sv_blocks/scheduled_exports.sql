{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('scheduled_exports_scd') }}
select
    _airbyte_unique_key,
    day_of_the_week,
    paused,
    columns,
    attachment_name,
    format,
    created_at,
    uuid,
    table_name,
    frequency,
    updated_at,
    user_id,
    time_zone_identifier,
    recipients,
    last_processed_at,
    id,
    hour_of_the_day,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_scheduled_exports_hashid
from {{ ref('scheduled_exports_scd') }}
-- scheduled_exports from {{ source('sv_blocks', '_airbyte_raw_scheduled_exports') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

