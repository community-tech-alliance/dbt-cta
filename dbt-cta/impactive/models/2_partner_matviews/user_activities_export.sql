select
    performs,
    user_email,
    utm_campaign,
    user_last_name,
    created_at,
    testimonial_note,
    completed,
    impressions,
    user_fullname,
    user_last_seen_at,
    exported_at,
    user_first_name,
    testimonial_media_url,
    updated_at,
    user_id,
    activity_id,
    clicks,
    user_phone,
    id,
    published_at,
    campaign_id,
    utm_source,
    activity_title,
    _airbyte_emitted_at,
    _airbyte_user_activities_export_hashid
from {{ source('cta','user_activities_export_base') }}