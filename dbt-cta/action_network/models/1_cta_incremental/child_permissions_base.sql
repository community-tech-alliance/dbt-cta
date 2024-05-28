{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('child_permissions_ab4') }}
select
    id,
    group_id,
    hierarchy,
    created_at,
    updated_at,
    permissions,
    source_group_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_child_permissions_hashid
from {{ ref('child_permissions_ab4') }}