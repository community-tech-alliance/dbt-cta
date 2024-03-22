{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_raw_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('ticketed_events_ab4') }}
select
    id,
    city,
    state,
    stats,
    title,
    end_at,
    hidden,
    status,
    address,
    country,
    user_id,
    group_id,
    language,
    start_at,
    tag_list,
    timezone,
    zip_code,
    permalink,
    share_url,
    show_goal,
    created_at,
    updated_at,
    slider_type,
    ticket_goal,
    contact_info,
    dollars_goal,
    has_end_date,
    instructions,
    recipient_id,
    ticket_count,
    csv_file_name,
    csv_file_size,
    custom_fields,
    first_publish,
    location_name,
    reminder_from,
    tickets_limit,
    csv_updated_at,
    recipient_type,
    display_creator,
    first_permalink,
    has_no_location,
    photo_file_name,
    photo_file_size,
    csv_content_type,
    description_info,
    description_text,
    photo_updated_at,
    reminder_message,
    reminder_subject,
    email_template_id,
    image_attribution,
    reminder_reply_to,
    thank_you_subhead,
    no_target_redirect,
    photo_content_type,
    thank_you_headline,
    disable_discussions,
    form_builder_output,
    administrative_title,
    automatic_notifications,
    display_sharing_options,
    donations_without_email,
    form_builder_output_json,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ticketed_events_hashid
from {{ ref('ticketed_events_ab4') }}
-- ticketed_events from {{ source('cta_raw', '_airbyte_raw_ticketed_events') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
