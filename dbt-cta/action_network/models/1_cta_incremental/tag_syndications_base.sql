{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('tag_syndications_ab4') }}
select
    id,
    tag_id,
    group_id,
    tag_name,
    hierarchy,
    created_at,
    updated_at,
    source_group_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tag_syndications_hashid
from {{ ref('tag_syndications_ab4') }}
