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
    _airbyte_user_files_hashid
from {{ source('cta','user_files_base') }}
