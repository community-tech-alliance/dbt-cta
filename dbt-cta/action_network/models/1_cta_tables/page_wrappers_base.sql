{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('page_wrappers_ab3') }}
select
    id,
    name,
    notes,
    footer,
    header,
    user_id,
    group_id,
    created_at,
    syndicated,
    updated_at,
    logo_file_name,
    logo_file_size,
    logo_dimensions,
    logo_content_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_page_wrappers_hashid
from {{ ref('page_wrappers_ab3') }}
-- page_wrappers from {{ source('cta', '_airbyte_raw_page_wrappers') }}
where 1 = 1

