{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('lists_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_lists_hashid
from {{ ref('lists_ab3') }}
-- lists from {{ source('cta', '_airbyte_raw_lists') }}
where 1 = 1

