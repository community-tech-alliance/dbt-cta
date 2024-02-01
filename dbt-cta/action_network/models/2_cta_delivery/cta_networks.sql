select
    id,
    name,
    terms,
    created_at,
    updated_at,
    sms_enabled,
    ip_pool_name,
    csv_file_name,
    csv_file_size,
    csv_updated_at,
    csv_content_type,
    lock_custom_fields,
    top_level_group_id,
    opted_in_mobile_number,
    _airbyte_networks_hashid
from {{ source('cta','networks_base') }}
