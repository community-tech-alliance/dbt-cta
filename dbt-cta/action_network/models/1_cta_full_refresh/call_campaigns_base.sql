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
-- depends_on: {{ ref('call_campaigns_ab4') }}
select
    id,
    uuid,
    stats,
    title,
    hidden,
    status,
    target,
    boolean,
    user_id,
    group_id,
    language,
    tag_list,
    call_goal,
    permalink,
    share_url,
    show_goal,
    test_mode,
    call_count,
    created_at,
    updated_at,
    browser_url,
    description,
    instructions,
    phone_number,
    click_to_call,
    csv_file_name,
    csv_file_size,
    custom_fields,
    first_publish,
    csv_updated_at,
    display_creator,
    first_permalink,
    photo_file_name,
    photo_file_size,
    csv_content_type,
    description_info,
    phone_number_sid,
    image_attribution,
    thank_you_subhead,
    thankyou_sms_text,
    no_target_redirect,
    originating_system,
    photo_content_type,
    thank_you_headline,
    form_builder_output,
    submit_button_title,
    administrative_title,
    thankyou_sms_enabled,
    audio_message_file_name,
    audio_message_file_size,
    display_sharing_options,
    audio_message_updated_at,
    form_builder_output_json,
    audio_message_content_type,
    targets_not_found_sms_text,
    targets_not_found_sms_enabled,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_call_campaigns_hashid
from {{ ref('call_campaigns_ab4') }}
-- call_campaigns from {{ source('cta', '_airbyte_raw_call_campaigns') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_extracted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
