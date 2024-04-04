{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('call_campaigns_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'stats',
        'title',
        'hidden',
        'status',
        'target',
        'boolean',
        'user_id',
        'group_id',
        'language',
        'tag_list',
        'call_goal',
        'permalink',
        'share_url',
        'show_goal',
        'test_mode',
        'call_count',
        'created_at',
        'updated_at',
        'browser_url',
        'description',
        'instructions',
        'phone_number',
        'click_to_call',
        'csv_file_name',
        'csv_file_size',
        'custom_fields',
        'first_publish',
        'csv_updated_at',
        'display_creator',
        'first_permalink',
        'photo_file_name',
        'photo_file_size',
        'csv_content_type',
        'description_info',
        'phone_number_sid',
        'image_attribution',
        'thank_you_subhead',
        'thankyou_sms_text',
        'no_target_redirect',
        'originating_system',
        'photo_content_type',
        'thank_you_headline',
        'form_builder_output',
        'submit_button_title',
        'administrative_title',
        'thankyou_sms_enabled',
        'audio_message_file_name',
        'audio_message_file_size',
        'display_sharing_options',
        'audio_message_updated_at',
        'form_builder_output_json',
        'audio_message_content_type',
        'targets_not_found_sms_text',
        'targets_not_found_sms_enabled',
    ]) }} as _airbyte_call_campaigns_hashid,
    tmp.*
from {{ ref('call_campaigns_ab2') }} as tmp
-- call_campaigns
where 1 = 1
