{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('groupings_ab4') }}
select
    collection_id,
    updated_at,
    name,
    created_at,
    description,
    id,
    position,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_groupings_hashid
from {{ ref('groupings_ab4') }}
-- groupings from {{ source('cta', '_airbyte_raw_groupings') }}
