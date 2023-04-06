{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('electoral_districts_ab3') }}
select
    code,
    name,
    ocd_id,
    created_at,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_electoral_districts_hashid
from {{ ref('electoral_districts_ab3') }}
-- electoral_districts from {{ source('cta', '_airbyte_raw_electoral_districts') }}
where 1 = 1

