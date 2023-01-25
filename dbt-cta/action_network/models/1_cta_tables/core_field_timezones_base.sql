{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('core_field_timezones_ab3') }}
select
    id,
    timezone,
    created_at,
    updated_at,
    core_field_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_core_field_timezones_hashid
from {{ ref('core_field_timezones_ab3') }}
-- core_field_timezones from {{ source('cta', '_airbyte_raw_core_field_timezones') }}
where 1 = 1

