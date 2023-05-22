select
    id,
    title,
    failure,
    user_id,
    group_id,
    shapefile,
    created_at,
    updated_at,
    fail_message,
    csv_file_name,
    csv_file_size,
    network_share,
    csv_content_type,
    _airbyte_targets_hashid
from {{ source('cta','targets_base') }}