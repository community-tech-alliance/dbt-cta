{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "usvote_foundation",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('regions_ab3') }}
select
    id,
    state,
    county,
    state_abbr,
    state_name,
    county_name,
    region_name,
    municipality,
    resource_uri,
    municipality_name,
    municipality_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_regions_hashid
from {{ ref('regions_ab3') }}
-- regions from {{ source('cta', '_airbyte_raw_regions') }}
where 1 = 1

