{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('grouping_measurements_ab4') }}
select
    measurable_id,
    grouping_id,
    id,
    position,
    measurable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_grouping_measurements_hashid
from {{ ref('grouping_measurements_ab4') }}
-- grouping_measurements from {{ source('cta', '_airbyte_raw_grouping_measurements') }}
