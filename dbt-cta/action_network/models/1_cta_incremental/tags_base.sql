{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('tags_ab4') }}
select
    id,
    name,
    uuid,
    notes,
    group_id,
    created_at,
    updated_at,
    parent_group_id,
    sent_to_children,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tags_hashid
from {{ ref('tags_ab4') }}
