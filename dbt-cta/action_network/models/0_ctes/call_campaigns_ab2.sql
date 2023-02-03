{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('call_campaigns_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(stats as {{ dbt_utils.type_string() }}) as stats,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(target as {{ dbt_utils.type_string() }}) as target,
    cast(boolean as {{ dbt_utils.type_bigint() }}) as boolean,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(language as {{ dbt_utils.type_string() }}) as language,
    cast(tag_list as {{ dbt_utils.type_string() }}) as tag_list,
    cast(call_goal as {{ dbt_utils.type_bigint() }}) as call_goal,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(share_url as {{ dbt_utils.type_string() }}) as share_url,
    cast(show_goal as {{ dbt_utils.type_bigint() }}) as show_goal,
    cast(test_mode as {{ dbt_utils.type_bigint() }}) as test_mode,
    cast(call_count as {{ dbt_utils.type_bigint() }}) as call_count,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(browser_url as {{ dbt_utils.type_string() }}) as browser_url,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(instructions as {{ dbt_utils.type_string() }}) as instructions,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(click_to_call as {{ dbt_utils.type_bigint() }}) as click_to_call,
    cast(csv_file_name as {{ dbt_utils.type_string() }}) as csv_file_name,
    cast(csv_file_size as {{ dbt_utils.type_bigint() }}) as csv_file_size,
    cast(custom_fields as {{ dbt_utils.type_string() }}) as custom_fields,
    cast(first_publish as {{ dbt_utils.type_bigint() }}) as first_publish,
    cast(csv_updated_at as {{ dbt_utils.type_string() }}) as csv_updated_at,
    cast(display_creator as {{ dbt_utils.type_bigint() }}) as display_creator,
    cast(first_permalink as {{ dbt_utils.type_string() }}) as first_permalink,
    cast(photo_file_name as {{ dbt_utils.type_string() }}) as photo_file_name,
    cast(photo_file_size as {{ dbt_utils.type_bigint() }}) as photo_file_size,
    cast(csv_content_type as {{ dbt_utils.type_string() }}) as csv_content_type,
    cast(description_info as {{ dbt_utils.type_string() }}) as description_info,
    cast(phone_number_sid as {{ dbt_utils.type_string() }}) as phone_number_sid,
    cast(image_attribution as {{ dbt_utils.type_string() }}) as image_attribution,
    cast(thank_you_subhead as {{ dbt_utils.type_string() }}) as thank_you_subhead,
    cast(thankyou_sms_text as {{ dbt_utils.type_string() }}) as thankyou_sms_text,
    cast(no_target_redirect as {{ dbt_utils.type_string() }}) as no_target_redirect,
    cast(originating_system as {{ dbt_utils.type_string() }}) as originating_system,
    cast(photo_content_type as {{ dbt_utils.type_string() }}) as photo_content_type,
    cast(thank_you_headline as {{ dbt_utils.type_string() }}) as thank_you_headline,
    cast(form_builder_output as {{ dbt_utils.type_string() }}) as form_builder_output,
    cast(submit_button_title as {{ dbt_utils.type_string() }}) as submit_button_title,
    cast(administrative_title as {{ dbt_utils.type_string() }}) as administrative_title,
    cast(thankyou_sms_enabled as {{ dbt_utils.type_bigint() }}) as thankyou_sms_enabled,
    cast(audio_message_file_name as {{ dbt_utils.type_string() }}) as audio_message_file_name,
    cast(audio_message_file_size as {{ dbt_utils.type_bigint() }}) as audio_message_file_size,
    cast(display_sharing_options as {{ dbt_utils.type_bigint() }}) as display_sharing_options,
    cast(audio_message_updated_at as {{ dbt_utils.type_string() }}) as audio_message_updated_at,
    cast(form_builder_output_json as {{ dbt_utils.type_string() }}) as form_builder_output_json,
    cast(audio_message_content_type as {{ dbt_utils.type_string() }}) as audio_message_content_type,
    cast(targets_not_found_sms_text as {{ dbt_utils.type_string() }}) as targets_not_found_sms_text,
    cast(targets_not_found_sms_enabled as {{ dbt_utils.type_bigint() }}) as targets_not_found_sms_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('call_campaigns_ab1') }}
-- call_campaigns
where 1 = 1

