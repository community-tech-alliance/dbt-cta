{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_groups') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['stats'], ['stats']) }} as stats,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['street'], ['street']) }} as street,
    {{ json_extract_scalar('_airbyte_data', ['api_key'], ['api_key']) }} as api_key,
    {{ json_extract_scalar('_airbyte_data', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('_airbyte_data', ['signoff'], ['signoff']) }} as signoff,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['language'], ['language']) }} as language,
    {{ json_extract_scalar('_airbyte_data', ['latitude'], ['latitude']) }} as latitude,
    {{ json_extract_scalar('_airbyte_data', ['zip_code'], ['zip_code']) }} as zip_code,
    {{ json_extract_scalar('_airbyte_data', ['longitude'], ['longitude']) }} as longitude,
    {{ json_extract_scalar('_airbyte_data', ['parent_id'], ['parent_id']) }} as parent_id,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['sms_stats'], ['sms_stats']) }} as sms_stats,
    {{ json_extract_scalar('_airbyte_data', ['auto_merge'], ['auto_merge']) }} as auto_merge,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['discussion'], ['discussion']) }} as discussion,
    {{ json_extract_scalar('_airbyte_data', ['email_from'], ['email_from']) }} as email_from,
    {{ json_extract_scalar('_airbyte_data', ['network_id'], ['network_id']) }} as network_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['sms_enabled'], ['sms_enabled']) }} as sms_enabled,
    {{ json_extract_scalar('_airbyte_data', ['users_count'], ['users_count']) }} as users_count,
    {{ json_extract_scalar('_airbyte_data', ['applications'], ['applications']) }} as applications,
    {{ json_extract_scalar('_airbyte_data', ['ip_pool_name'], ['ip_pool_name']) }} as ip_pool_name,
    {{ json_extract_scalar('_airbyte_data', ['localization'], ['localization']) }} as localization,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_name'], ['csv_file_name']) }} as csv_file_name,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_size'], ['csv_file_size']) }} as csv_file_size,
    {{ json_extract_scalar('_airbyte_data', ['email_replyto'], ['email_replyto']) }} as email_replyto,
    {{ json_extract_scalar('_airbyte_data', ['first_publish'], ['first_publish']) }} as first_publish,
    {{ json_extract_scalar('_airbyte_data', ['twilio_active'], ['twilio_active']) }} as twilio_active,
    {{ json_extract_scalar('_airbyte_data', ['csv_updated_at'], ['csv_updated_at']) }} as csv_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['additional_text'], ['additional_text']) }} as additional_text,
    {{ json_extract_scalar('_airbyte_data', ['adhoc_group_ids'], ['adhoc_group_ids']) }} as adhoc_group_ids,
    {{ json_extract_scalar('_airbyte_data', ['default_country'], ['default_country']) }} as default_country,
    {{ json_extract_scalar('_airbyte_data', ['first_permalink'], ['first_permalink']) }} as first_permalink,
    {{ json_extract_scalar('_airbyte_data', ['photo_file_name'], ['photo_file_name']) }} as photo_file_name,
    {{ json_extract_scalar('_airbyte_data', ['photo_file_size'], ['photo_file_size']) }} as photo_file_size,
    {{ json_extract_scalar('_airbyte_data', ['cancel_donations'], ['cancel_donations']) }} as cancel_donations,
    {{ json_extract_scalar('_airbyte_data', ['csv_content_type'], ['csv_content_type']) }} as csv_content_type,
    {{ json_extract_scalar('_airbyte_data', ['description_text'], ['description_text']) }} as description_text,
    {{ json_extract_scalar('_airbyte_data', ['campaigns_enabled'], ['campaigns_enabled']) }} as campaigns_enabled,
    {{ json_extract_scalar('_airbyte_data', ['default_report_id'], ['default_report_id']) }} as default_report_id,
    {{ json_extract_scalar('_airbyte_data', ['image_attribution'], ['image_attribution']) }} as image_attribution,
    {{ json_extract_scalar('_airbyte_data', ['notify_mass_email'], ['notify_mass_email']) }} as notify_mass_email,
    {{ json_extract_scalar('_airbyte_data', ['redirects_enabled'], ['redirects_enabled']) }} as redirects_enabled,
    {{ json_extract_scalar('_airbyte_data', ['photo_content_type'], ['photo_content_type']) }} as photo_content_type,
    {{ json_extract_scalar('_airbyte_data', ['flow_up_sms_opt_ins'], ['flow_up_sms_opt_ins']) }} as flow_up_sms_opt_ins,
    {{ json_extract_scalar('_airbyte_data', ['twilio_help_message'], ['twilio_help_message']) }} as twilio_help_message,
    {{ json_extract_scalar('_airbyte_data', ['use_additional_text'], ['use_additional_text']) }} as use_additional_text,
    {{ json_extract_scalar('_airbyte_data', ['administrative_title'], ['administrative_title']) }} as administrative_title,
    {{ json_extract_scalar('_airbyte_data', ['donation_failed_email'], ['donation_failed_email']) }} as donation_failed_email,
    {{ json_extract_scalar('_airbyte_data', ['mass_emails_to_notify'], ['mass_emails_to_notify']) }} as mass_emails_to_notify,
    {{ json_extract_scalar('_airbyte_data', ['network_csv_file_name'], ['network_csv_file_name']) }} as network_csv_file_name,
    {{ json_extract_scalar('_airbyte_data', ['network_csv_file_size'], ['network_csv_file_size']) }} as network_csv_file_size,
    {{ json_extract_scalar('_airbyte_data', ['default_twitter_handle'], ['default_twitter_handle']) }} as default_twitter_handle,
    {{ json_extract_scalar('_airbyte_data', ['donation_receipt_email'], ['donation_receipt_email']) }} as donation_receipt_email,
    {{ json_extract_scalar('_airbyte_data', ['network_csv_updated_at'], ['network_csv_updated_at']) }} as network_csv_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['salesforce_last_update'], ['salesforce_last_update']) }} as salesforce_last_update,
    {{ json_extract_scalar('_airbyte_data', ['current_page_wrapper_id'], ['current_page_wrapper_id']) }} as current_page_wrapper_id,
    {{ json_extract_scalar('_airbyte_data', ['salesforce_sync_enabled'], ['salesforce_sync_enabled']) }} as salesforce_sync_enabled,
    {{ json_extract_scalar('_airbyte_data', ['use_affirmative_opt_ins'], ['use_affirmative_opt_ins']) }} as use_affirmative_opt_ins,
    {{ json_extract_scalar('_airbyte_data', ['donations_without_emails'], ['donations_without_emails']) }} as donations_without_emails,
    {{ json_extract_scalar('_airbyte_data', ['network_csv_content_type'], ['network_csv_content_type']) }} as network_csv_content_type,
    {{ json_extract_scalar('_airbyte_data', ['salesforce_custom_fields'], ['salesforce_custom_fields']) }} as salesforce_custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['current_email_template_id'], ['current_email_template_id']) }} as current_email_template_id,
    {{ json_extract_scalar('_airbyte_data', ['email_stats_csv_file_name'], ['email_stats_csv_file_name']) }} as email_stats_csv_file_name,
    {{ json_extract_scalar('_airbyte_data', ['email_stats_csv_file_size'], ['email_stats_csv_file_size']) }} as email_stats_csv_file_size,
    {{ json_extract_scalar('_airbyte_data', ['additional_sms_opt_in_text'], ['additional_sms_opt_in_text']) }} as additional_sms_opt_in_text,
    {{ json_extract_scalar('_airbyte_data', ['email_stats_csv_updated_at'], ['email_stats_csv_updated_at']) }} as email_stats_csv_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['salesforce_sync_successful'], ['salesforce_sync_successful']) }} as salesforce_sync_successful,
    {{ json_extract_scalar('_airbyte_data', ['twilio_unsubscribe_message'], ['twilio_unsubscribe_message']) }} as twilio_unsubscribe_message,
    {{ json_extract_scalar('_airbyte_data', ['default_targeting_exclude_id'], ['default_targeting_exclude_id']) }} as default_targeting_exclude_id,
    {{ json_extract_scalar('_airbyte_data', ['default_targeting_include_id'], ['default_targeting_include_id']) }} as default_targeting_include_id,
    {{ json_extract_scalar('_airbyte_data', ['email_stats_csv_content_type'], ['email_stats_csv_content_type']) }} as email_stats_csv_content_type,
    {{ json_extract_scalar('_airbyte_data', ['cancel_donations_instructions'], ['cancel_donations_instructions']) }} as cancel_donations_instructions,
    {{ json_extract_scalar('_airbyte_data', ['default_facebook_image_file_name'], ['default_facebook_image_file_name']) }} as default_facebook_image_file_name,
    {{ json_extract_scalar('_airbyte_data', ['default_facebook_image_file_size'], ['default_facebook_image_file_size']) }} as default_facebook_image_file_size,
    {{ json_extract_scalar('_airbyte_data', ['default_facebook_image_updated_at'], ['default_facebook_image_updated_at']) }} as default_facebook_image_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['mobile_message_stats_csv_file_name'], ['mobile_message_stats_csv_file_name']) }} as mobile_message_stats_csv_file_name,
    {{ json_extract_scalar('_airbyte_data', ['mobile_message_stats_csv_file_size'], ['mobile_message_stats_csv_file_size']) }} as mobile_message_stats_csv_file_size,
    {{ json_extract_scalar('_airbyte_data', ['default_facebook_image_content_type'], ['default_facebook_image_content_type']) }} as default_facebook_image_content_type,
    {{ json_extract_scalar('_airbyte_data', ['mobile_message_stats_csv_updated_at'], ['mobile_message_stats_csv_updated_at']) }} as mobile_message_stats_csv_updated_at,
    {{ json_extract_scalar('_airbyte_data', ['mobile_message_stats_csv_content_type'], ['mobile_message_stats_csv_content_type']) }} as mobile_message_stats_csv_content_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_groups') }}
-- groups
where 1 = 1
