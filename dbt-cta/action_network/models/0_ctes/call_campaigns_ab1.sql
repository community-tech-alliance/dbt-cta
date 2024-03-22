{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_call_campaigns') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['stats'], ['stats']) }} as stats,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['hidden'], ['hidden']) }} as hidden,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['target'], ['target']) }} as target,
    {{ json_extract_scalar('_airbyte_data', ['boolean'], ['boolean']) }} as boolean,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['language'], ['language']) }} as language,
    {{ json_extract_scalar('_airbyte_data', ['tag_list'], ['tag_list']) }} as tag_list,
    {{ json_extract_scalar('_airbyte_data', ['call_goal'], ['call_goal']) }} as call_goal,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['share_url'], ['share_url']) }} as share_url,
    {{ json_extract_scalar('_airbyte_data', ['show_goal'], ['show_goal']) }} as show_goal,
    {{ json_extract_scalar('_airbyte_data', ['test_mode'], ['test_mode']) }} as test_mode,
    {{ json_extract_scalar('_airbyte_data', ['call_count'], ['call_count']) }} as call_count,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['browser_url'], ['browser_url']) }} as browser_url,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['instructions'], ['instructions']) }} as instructions,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['click_to_call'], ['click_to_call']) }} as click_to_call,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_name'], ['csv_file_name']) }} as csv_file_name,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_size'], ['csv_file_size']) }} as csv_file_size,
    {{ json_extract_scalar('_airbyte_data', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['first_publish'], ['first_publish']) }} as first_publish,
    {{ json_extract_scalar('_airbyte_data', ['csv_updated_at'], ['csv_updated_at']) }} as csv_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['display_creator'], ['display_creator']) }} as display_creator,
    {{ json_extract_scalar('_airbyte_data', ['first_permalink'], ['first_permalink']) }} as first_permalink,
    {{ json_extract_scalar('_airbyte_data', ['photo_file_name'], ['photo_file_name']) }} as photo_file_name,
    {{ json_extract_scalar('_airbyte_data', ['photo_file_size'], ['photo_file_size']) }} as photo_file_size,
    {{ json_extract_scalar('_airbyte_data', ['csv_content_type'], ['csv_content_type']) }} as csv_content_type,
    {{ json_extract_scalar('_airbyte_data', ['description_info'], ['description_info']) }} as description_info,
    {{ json_extract_scalar('_airbyte_data', ['phone_number_sid'], ['phone_number_sid']) }} as phone_number_sid,
    {{ json_extract_scalar('_airbyte_data', ['image_attribution'], ['image_attribution']) }} as image_attribution,
    {{ json_extract_scalar('_airbyte_data', ['thank_you_subhead'], ['thank_you_subhead']) }} as thank_you_subhead,
    {{ json_extract_scalar('_airbyte_data', ['thankyou_sms_text'], ['thankyou_sms_text']) }} as thankyou_sms_text,
    {{ json_extract_scalar('_airbyte_data', ['no_target_redirect'], ['no_target_redirect']) }} as no_target_redirect,
    {{ json_extract_scalar('_airbyte_data', ['originating_system'], ['originating_system']) }} as originating_system,
    {{ json_extract_scalar('_airbyte_data', ['photo_content_type'], ['photo_content_type']) }} as photo_content_type,
    {{ json_extract_scalar('_airbyte_data', ['thank_you_headline'], ['thank_you_headline']) }} as thank_you_headline,
    {{ json_extract_scalar('_airbyte_data', ['form_builder_output'], ['form_builder_output']) }} as form_builder_output,
    {{ json_extract_scalar('_airbyte_data', ['submit_button_title'], ['submit_button_title']) }} as submit_button_title,
    {{ json_extract_scalar('_airbyte_data', ['administrative_title'], ['administrative_title']) }} as administrative_title,
    {{ json_extract_scalar('_airbyte_data', ['thankyou_sms_enabled'], ['thankyou_sms_enabled']) }} as thankyou_sms_enabled,
    {{ json_extract_scalar('_airbyte_data', ['audio_message_file_name'], ['audio_message_file_name']) }} as audio_message_file_name,
    {{ json_extract_scalar('_airbyte_data', ['audio_message_file_size'], ['audio_message_file_size']) }} as audio_message_file_size,
    {{ json_extract_scalar('_airbyte_data', ['display_sharing_options'], ['display_sharing_options']) }} as display_sharing_options,
    {{ json_extract_scalar('_airbyte_data', ['audio_message_updated_at'], ['audio_message_updated_at']) }} as audio_message_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['form_builder_output_json'], ['form_builder_output_json']) }} as form_builder_output_json,
    {{ json_extract_scalar('_airbyte_data', ['audio_message_content_type'], ['audio_message_content_type']) }} as audio_message_content_type,
    {{ json_extract_scalar('_airbyte_data', ['targets_not_found_sms_text'], ['targets_not_found_sms_text']) }} as targets_not_found_sms_text,
    {{ json_extract_scalar('_airbyte_data', ['targets_not_found_sms_enabled'], ['targets_not_found_sms_enabled']) }} as targets_not_found_sms_enabled,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_call_campaigns') }}
-- call_campaigns
where 1 = 1
