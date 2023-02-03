select
    id,
    uuid,
    title,
    hidden,
    status,
    user_id,
    group_id,
    language,
    permalink,
    created_at,
    updated_at,
    first_publish,
    first_permalink,
    photo_file_name,
    photo_file_size,
    description_text,
    image_attribution,
    photo_content_type,
    administrative_title
from {{ source('cta','campaigns_base') }}