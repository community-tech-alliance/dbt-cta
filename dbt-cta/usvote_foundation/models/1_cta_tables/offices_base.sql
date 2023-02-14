{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "usvote_foundation",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('offices_ab3') }}
select
    id,
    type,
    geoid,
    hours,
    notes,
    region,
    status,
    updated,
    addresses,
    officials,
    resource_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_offices_hashid
from {{ ref('offices_ab3') }}
-- offices from {{ source('cta', '_airbyte_raw_offices') }}
where 1 = 1

