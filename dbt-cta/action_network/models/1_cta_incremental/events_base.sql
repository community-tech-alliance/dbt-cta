{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('events_ab4') }}
select
    id,
    city,
    uuid,
    state,
    stats,
    title,
    end_at,
    hidden,
    status,
    address,
    country,
    private,
    user_id,
    group_id,
    language,
    latitude,
    start_at,
    tag_list,
    timezone,
    zip_code,
    longitude,
    permalink,
    rsvp_goal,
    share_url,
    show_goal,
    created_at,
    rsvp_count,
    rsvp_limit,
    updated_at,
    browser_url,
    target_name,
    allow_guests,
    contact_info,
    has_end_date,
    instructions,
    redirect_url,
    target_title,
    csv_file_name,
    csv_file_size,
    custom_fields,
    first_publish,
    location_name,
    notifications,
    reminder_from,
    salesforce_id,
    csv_updated_at,
    display_creator,
    event_upload_id,
    first_permalink,
    has_no_location,
    photo_file_name,
    photo_file_size,
    csv_content_type,
    description_info,
    description_text,
    reminder_message,
    reminder_subject,
    zip_code_present,
    email_template_id,
    event_campaign_id,
    image_attribution,
    last_name_present,
    reminder_reply_to,
    thank_you_subhead,
    zip_code_required,
    first_name_present,
    last_name_required,
    originating_system,
    photo_content_type,
    thank_you_headline,
    disable_discussions,
    first_name_required,
    form_builder_output,
    submit_button_title,
    target_organization,
    administrative_title,
    suppress_autoresponse,
    automatic_notifications,
    display_sharing_options,
    event_campaign_upload_id,
    form_builder_output_json,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_events_hashid
from {{ ref('events_ab4') }}
