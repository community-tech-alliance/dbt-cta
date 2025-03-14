{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_ticketed_events" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['stats'], ['stats']) }} as stats,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['end_at'], ['end_at']) }} as end_at,
    {{ json_extract_scalar('_airbyte_data', ['hidden'], ['hidden']) }} as hidden,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['language'], ['language']) }} as language,
    {{ json_extract_scalar('_airbyte_data', ['start_at'], ['start_at']) }} as start_at,
    {{ json_extract_scalar('_airbyte_data', ['tag_list'], ['tag_list']) }} as tag_list,
    {{ json_extract_scalar('_airbyte_data', ['timezone'], ['timezone']) }} as timezone,
    {{ json_extract_scalar('_airbyte_data', ['zip_code'], ['zip_code']) }} as zip_code,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['share_url'], ['share_url']) }} as share_url,
    {{ json_extract_scalar('_airbyte_data', ['show_goal'], ['show_goal']) }} as show_goal,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['slider_type'], ['slider_type']) }} as slider_type,
    {{ json_extract_scalar('_airbyte_data', ['ticket_goal'], ['ticket_goal']) }} as ticket_goal,
    {{ json_extract_scalar('_airbyte_data', ['contact_info'], ['contact_info']) }} as contact_info,
    {{ json_extract_scalar('_airbyte_data', ['dollars_goal'], ['dollars_goal']) }} as dollars_goal,
    {{ json_extract_scalar('_airbyte_data', ['has_end_date'], ['has_end_date']) }} as has_end_date,
    {{ json_extract_scalar('_airbyte_data', ['instructions'], ['instructions']) }} as instructions,
    {{ json_extract_scalar('_airbyte_data', ['recipient_id'], ['recipient_id']) }} as recipient_id,
    {{ json_extract_scalar('_airbyte_data', ['ticket_count'], ['ticket_count']) }} as ticket_count,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_name'], ['csv_file_name']) }} as csv_file_name,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_size'], ['csv_file_size']) }} as csv_file_size,
    {{ json_extract_scalar('_airbyte_data', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['first_publish'], ['first_publish']) }} as first_publish,
    {{ json_extract_scalar('_airbyte_data', ['location_name'], ['location_name']) }} as location_name,
    {{ json_extract_scalar('_airbyte_data', ['reminder_from'], ['reminder_from']) }} as reminder_from,
    {{ json_extract_scalar('_airbyte_data', ['tickets_limit'], ['tickets_limit']) }} as tickets_limit,
    {{ json_extract_scalar('_airbyte_data', ['csv_updated_at'], ['csv_updated_at']) }} as csv_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['recipient_type'], ['recipient_type']) }} as recipient_type,
    {{ json_extract_scalar('_airbyte_data', ['display_creator'], ['display_creator']) }} as display_creator,
    {{ json_extract_scalar('_airbyte_data', ['first_permalink'], ['first_permalink']) }} as first_permalink,
    {{ json_extract_scalar('_airbyte_data', ['has_no_location'], ['has_no_location']) }} as has_no_location,
    {{ json_extract_scalar('_airbyte_data', ['photo_file_name'], ['photo_file_name']) }} as photo_file_name,
    {{ json_extract_scalar('_airbyte_data', ['photo_file_size'], ['photo_file_size']) }} as photo_file_size,
    {{ json_extract_scalar('_airbyte_data', ['csv_content_type'], ['csv_content_type']) }} as csv_content_type,
    {{ json_extract_scalar('_airbyte_data', ['description_info'], ['description_info']) }} as description_info,
    {{ json_extract_scalar('_airbyte_data', ['description_text'], ['description_text']) }} as description_text,
    {{ json_extract_scalar('_airbyte_data', ['photo_updated_at'], ['photo_updated_at']) }} as photo_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['reminder_message'], ['reminder_message']) }} as reminder_message,
    {{ json_extract_scalar('_airbyte_data', ['reminder_subject'], ['reminder_subject']) }} as reminder_subject,
    {{ json_extract_scalar('_airbyte_data', ['email_template_id'], ['email_template_id']) }} as email_template_id,
    {{ json_extract_scalar('_airbyte_data', ['image_attribution'], ['image_attribution']) }} as image_attribution,
    {{ json_extract_scalar('_airbyte_data', ['reminder_reply_to'], ['reminder_reply_to']) }} as reminder_reply_to,
    {{ json_extract_scalar('_airbyte_data', ['thank_you_subhead'], ['thank_you_subhead']) }} as thank_you_subhead,
    {{ json_extract_scalar('_airbyte_data', ['no_target_redirect'], ['no_target_redirect']) }} as no_target_redirect,
    {{ json_extract_scalar('_airbyte_data', ['photo_content_type'], ['photo_content_type']) }} as photo_content_type,
    {{ json_extract_scalar('_airbyte_data', ['thank_you_headline'], ['thank_you_headline']) }} as thank_you_headline,
    {{ json_extract_scalar('_airbyte_data', ['disable_discussions'], ['disable_discussions']) }} as disable_discussions,
    {{ json_extract_scalar('_airbyte_data', ['form_builder_output'], ['form_builder_output']) }} as form_builder_output,
    {{ json_extract_scalar('_airbyte_data', ['administrative_title'], ['administrative_title']) }} as administrative_title,
    {{ json_extract_scalar('_airbyte_data', ['automatic_notifications'], ['automatic_notifications']) }} as automatic_notifications,
    {{ json_extract_scalar('_airbyte_data', ['display_sharing_options'], ['display_sharing_options']) }} as display_sharing_options,
    {{ json_extract_scalar('_airbyte_data', ['donations_without_email'], ['donations_without_email']) }} as donations_without_email,
    {{ json_extract_scalar('_airbyte_data', ['form_builder_output_json'], ['form_builder_output_json']) }} as form_builder_output_json,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- ticketed_events
where 1 = 1
