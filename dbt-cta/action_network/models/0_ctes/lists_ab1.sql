{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_lists') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['hidden'], ['hidden']) }} as hidden,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['failure'], ['failure']) }} as failure,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['start_at'], ['start_at']) }} as start_at,
    {{ json_extract_scalar('_airbyte_data', ['tag_list'], ['tag_list']) }} as tag_list,
    {{ json_extract_scalar('_airbyte_data', ['add_unsub'], ['add_unsub']) }} as add_unsub,
    {{ json_extract_scalar('_airbyte_data', ['list_type'], ['list_type']) }} as list_type,
    {{ json_extract_scalar('_airbyte_data', ['new_count'], ['new_count']) }} as new_count,
    {{ json_extract_scalar('_airbyte_data', ['overwrite'], ['overwrite']) }} as overwrite,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['delete_subs'], ['delete_subs']) }} as delete_subs,
    {{ json_extract_scalar('_airbyte_data', ['total_count'], ['total_count']) }} as total_count,
    {{ json_extract_scalar('_airbyte_data', ['unsubscribe'], ['unsubscribe']) }} as unsubscribe,
    {{ json_extract_scalar('_airbyte_data', ['upload_type'], ['upload_type']) }} as upload_type,
    {{ json_extract_scalar('_airbyte_data', ['fail_message'], ['fail_message']) }} as fail_message,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_name'], ['csv_file_name']) }} as csv_file_name,
    {{ json_extract_scalar('_airbyte_data', ['csv_file_size'], ['csv_file_size']) }} as csv_file_size,
    {{ json_extract_scalar('_airbyte_data', ['field_mapping'], ['field_mapping']) }} as field_mapping,
    {{ json_extract_scalar('_airbyte_data', ['skip_triggers'], ['skip_triggers']) }} as skip_triggers,
    {{ json_extract_scalar('_airbyte_data', ['overwrite_subs'], ['overwrite_subs']) }} as overwrite_subs,
    {{ json_extract_scalar('_airbyte_data', ['uploaded_by_id'], ['uploaded_by_id']) }} as uploaded_by_id,
    {{ json_extract_scalar('_airbyte_data', ['delete_sms_subs'], ['delete_sms_subs']) }} as delete_sms_subs,
    {{ json_extract_scalar('_airbyte_data', ['unsubscribe_sms'], ['unsubscribe_sms']) }} as unsubscribe_sms,
    {{ json_extract_scalar('_airbyte_data', ['csv_content_type'], ['csv_content_type']) }} as csv_content_type,
    {{ json_extract_scalar('_airbyte_data', ['delete_new_users'], ['delete_new_users']) }} as delete_new_users,
    {{ json_extract_scalar('_airbyte_data', ['new_mobile_count'], ['new_mobile_count']) }} as new_mobile_count,
    {{ json_extract_scalar('_airbyte_data', ['total_rows_count'], ['total_rows_count']) }} as total_rows_count,
    {{ json_extract_scalar('_airbyte_data', ['add_sms_subscribed'], ['add_sms_subscribed']) }} as add_sms_subscribed,
    {{ json_extract_scalar('_airbyte_data', ['clear_blank_fields'], ['clear_blank_fields']) }} as clear_blank_fields,
    {{ json_extract_scalar('_airbyte_data', ['overwrite_sms_subs'], ['overwrite_sms_subs']) }} as overwrite_sms_subs,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_lists') }} as table_alias
-- lists
where 1 = 1

