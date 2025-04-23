{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_emails" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['to'], ['to']) }} as {{ adapter.quote('to') }},
    {{ json_extract_scalar('_airbyte_data', ['body'], ['body']) }} as body,
    {{ json_extract_scalar('_airbyte_data', ['from'], ['from']) }} as {{ adapter.quote('from') }},
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['stats'], ['stats']) }} as stats,
    {{ json_extract_scalar('_airbyte_data', ['hidden'], ['hidden']) }} as hidden,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['subject'], ['subject']) }} as subject,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['reply_to'], ['reply_to']) }} as reply_to,
    {{ json_extract_scalar('_airbyte_data', ['tag_list'], ['tag_list']) }} as tag_list,
    {{ json_extract_scalar('_airbyte_data', ['stream_id'], ['stream_id']) }} as stream_id,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['send_date'], ['send_date']) }} as send_date,
    {{ json_extract_scalar('_airbyte_data', ['timezones'], ['timezones']) }} as timezones,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['is_sending'], ['is_sending']) }} as is_sending,
    {{ json_extract_scalar('_airbyte_data', ['pre_header'], ['pre_header']) }} as pre_header,
    {{ json_extract_scalar('_airbyte_data', ['total_sent'], ['total_sent']) }} as total_sent,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['finish_send'], ['finish_send']) }} as finish_send,
    {{ json_extract_scalar('_airbyte_data', ['builder_html'], ['builder_html']) }} as builder_html,
    {{ json_extract_scalar('_airbyte_data', ['builder_json'], ['builder_json']) }} as builder_json,
    {{ json_extract_scalar('_airbyte_data', ['button_color'], ['button_color']) }} as button_color,
    {{ json_extract_scalar('_airbyte_data', ['delivered_at'], ['delivered_at']) }} as delivered_at,
    {{ json_extract_scalar('_airbyte_data', ['actions_count'], ['actions_count']) }} as actions_count,
    {{ json_extract_scalar('_airbyte_data', ['target_option'], ['target_option']) }} as target_option,
    {{ json_extract_scalar('_airbyte_data', ['typeface_color'], ['typeface_color']) }} as typeface_color,
    {{ json_extract_scalar('_airbyte_data', ['first_permalink'], ['first_permalink']) }} as first_permalink,
    {{ json_extract_scalar('_airbyte_data', ['inlined_content'], ['inlined_content']) }} as inlined_content,
    {{ json_extract_scalar('_airbyte_data', ['parent_email_id'], ['parent_email_id']) }} as parent_email_id,
    {{ json_extract_scalar('_airbyte_data', ['button_text_color'], ['button_text_color']) }} as button_text_color,
    {{ json_extract_scalar('_airbyte_data', ['email_template_id'], ['email_template_id']) }} as email_template_id,
    {{ json_extract_scalar('_airbyte_data', ['administrative_title'], ['administrative_title']) }} as administrative_title,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- emails
where 1 = 1
