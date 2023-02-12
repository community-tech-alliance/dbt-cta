{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('event_campaigns_ab3') }}
select
    id,
    uuid,
    stats,
    title,
    hidden,
    status,
    user_id,
    group_id,
    language,
    tag_list,
    permalink,
    show_goal,
    created_at,
    discussion,
    events_csv,
    host_pitch,
    updated_at,
    browser_url,
    custom_html,
    default_from,
    csv_file_name,
    csv_file_size,
    default_email,
    first_publish,
    notifications,
    attendee_pitch,
    csv_updated_at,
    default_message,
    default_subject,
    first_permalink,
    hosting_options,
    photo_file_name,
    photo_file_size,
    csv_content_type,
    default_reply_to,
    host_page_status,
    event_description,
    host_instructions,
    image_attribution,
    thank_you_subhead,
    originating_system,
    photo_content_type,
    thank_you_headline,
    default_direct_link,
    default_email_share,
    form_builder_output,
    administrative_title,
    attendee_page_status,
    default_redirect_url,
    events_csv_file_name,
    events_csv_file_size,
    attendee_instructions,
    default_facebook_link,
    default_reminder_from,
    default_twitter_share,
    events_csv_updated_at,
    default_email_response,
    default_facebook_share,
    default_facebook_title,
    events_csv_content_type,
    default_reminder_message,
    default_reminder_subject,
    form_builder_output_json,
    default_email_template_id,
    default_reminder_reply_to,
    default_auto_response_email,
    default_unpublished_redirect,
    default_automatic_notifications,
    default_facebook_image_file_name,
    default_facebook_image_file_size,
    default_facebook_image_content_type,
    default_auto_response_email_template_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_event_campaigns_hashid
from {{ ref('event_campaigns_ab3') }}
-- event_campaigns from {{ source('cta', '_airbyte_raw_event_campaigns') }}
where 1 = 1
