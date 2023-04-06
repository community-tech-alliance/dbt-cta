{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_files_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_files_hashid
from {{ ref('user_files_ab3') }}
-- user_files from {{ source('cta', '_airbyte_raw_user_files') }}
where 1 = 1

