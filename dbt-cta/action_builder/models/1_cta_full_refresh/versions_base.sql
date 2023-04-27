{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('versions_ab3') }}
select
    id,
    event,
    object,
    item_id,
    item_type,
    whodunnit,
    created_at,
    object_changes,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_versions_hashid
from {{ ref('versions_ab3') }}
-- versions from {{ source('cta', '_airbyte_raw_versions') }}
where 1 = 1

