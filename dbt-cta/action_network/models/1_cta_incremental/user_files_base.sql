{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_files_ab4') }}
select
    id,
    name,
    {{ adapter.quote('order') }},
    user_id,
    group_id,
    file_type,
    mime_type,
    parent_id,
    permalink,
    created_at,
    updated_at,
    description,
    download_number,
    user_file_file_name,
    user_file_file_size,
    user_file_content_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_files_hashid
from {{ ref('user_files_ab4') }}
