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
-- depends_on: {{ ref('emails_ab4') }}
select
    id,
    {{ adapter.quote('to') }},
    body,
    {{ adapter.quote('from') }},
    uuid,
    stats,
    hidden,
    status,
    subject,
    user_id,
    group_id,
    reply_to,
    tag_list,
    permalink,
    send_date,
    timezones,
    created_at,
    is_sending,
    pre_header,
    total_sent,
    updated_at,
    finish_send,
    builder_html,
    builder_json,
    button_color,
    delivered_at,
    actions_count,
    target_option,
    typeface_color,
    first_permalink,
    inlined_content,
    parent_email_id,
    button_text_color,
    email_template_id,
    administrative_title,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_emails_hashid
from {{ ref('emails_ab4') }}