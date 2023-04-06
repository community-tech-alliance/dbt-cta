select
    id,
    {{ adapter.quote('rows') }},
    failure,
    user_id,
    created_at,
    updated_at,
    upload_type,
    fail_message,
    csv_file_name,
    csv_file_size,
    csv_content_type,
    event_campaign_id
from {{ source('cta','event_campaign_uploads_base') }}