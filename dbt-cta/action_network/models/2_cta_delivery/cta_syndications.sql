select
    id,
    uuid,
    stats,
    title,
    hidden,
    status,
    user_id,
    email_id,
    group_id,
    action_id,
    permalink,
    created_at,
    updated_at,
    action_type,
    description,
    first_publish,
    salesforce_id,
    display_creator,
    first_permalink,
    photo_file_name,
    photo_file_size,
    originating_system,
    photo_content_type,
    _airbyte_syndications_hashid
from {{ source('cta','syndications_base') }}
