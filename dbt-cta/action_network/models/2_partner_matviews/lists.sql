select
    id,
    title,
    hidden,
    status,
    failure,
    user_id,
    group_id,
    start_at,
    tag_list,
    add_unsub,
    list_type,
    new_count,
    overwrite,
    permalink,
    created_at,
    updated_at,
    delete_subs,
    total_count,
    unsubscribe,
    upload_type,
    fail_message,
    csv_file_name,
    csv_file_size,
    field_mapping,
    skip_triggers,
    overwrite_subs,
    uploaded_by_id,
    delete_sms_subs,
    unsubscribe_sms,
    csv_content_type,
    delete_new_users,
    new_mobile_count,
    total_rows_count,
    add_sms_subscribed,
    clear_blank_fields,
    overwrite_sms_subs,
    _airbyte_lists_hashid
from {{ source('cta','lists_base') }}