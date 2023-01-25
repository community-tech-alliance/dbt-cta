{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ticketed_events_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'city',
        'state',
        'stats',
        'title',
        'end_at',
        'hidden',
        'status',
        'address',
        'country',
        'user_id',
        'group_id',
        'language',
        'start_at',
        'tag_list',
        'timezone',
        'zip_code',
        'permalink',
        'share_url',
        'show_goal',
        'created_at',
        'updated_at',
        'slider_type',
        'ticket_goal',
        'contact_info',
        'dollars_goal',
        'has_end_date',
        'instructions',
        'recipient_id',
        'ticket_count',
        'csv_file_name',
        'csv_file_size',
        'custom_fields',
        'first_publish',
        'location_name',
        'reminder_from',
        'tickets_limit',
        'csv_updated_at',
        'recipient_type',
        'display_creator',
        'first_permalink',
        'has_no_location',
        'photo_file_name',
        'photo_file_size',
        'csv_content_type',
        'description_info',
        'description_text',
        'photo_updated_at',
        'reminder_message',
        'reminder_subject',
        'email_template_id',
        'image_attribution',
        'reminder_reply_to',
        'thank_you_subhead',
        'no_target_redirect',
        'photo_content_type',
        'thank_you_headline',
        'disable_discussions',
        'form_builder_output',
        'administrative_title',
        'automatic_notifications',
        'display_sharing_options',
        'donations_without_email',
        'form_builder_output_json',
    ]) }} as _airbyte_ticketed_events_hashid,
    tmp.*
from {{ ref('ticketed_events_ab2') }} tmp
-- ticketed_events
where 1 = 1

