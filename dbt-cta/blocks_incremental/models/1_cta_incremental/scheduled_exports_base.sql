{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('scheduled_exports_ab4') }}
select
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
from {{ ref('scheduled_exports_ab4') }}
-- scheduled_exports from {{ source('cta', '_airbyte_raw_scheduled_exports') }}
