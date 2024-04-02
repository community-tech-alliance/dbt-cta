{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('lists_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(failure as {{ dbt_utils.type_bigint() }}) as failure,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(start_at as {{ dbt_utils.type_string() }}) as start_at,
    cast(tag_list as {{ dbt_utils.type_string() }}) as tag_list,
    cast(add_unsub as {{ dbt_utils.type_bigint() }}) as add_unsub,
    cast(list_type as {{ dbt_utils.type_string() }}) as list_type,
    cast(new_count as {{ dbt_utils.type_bigint() }}) as new_count,
    cast(overwrite as {{ dbt_utils.type_bigint() }}) as overwrite,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(delete_subs as {{ dbt_utils.type_bigint() }}) as delete_subs,
    cast(total_count as {{ dbt_utils.type_bigint() }}) as total_count,
    cast(unsubscribe as {{ dbt_utils.type_bigint() }}) as unsubscribe,
    cast(upload_type as {{ dbt_utils.type_string() }}) as upload_type,
    cast(fail_message as {{ dbt_utils.type_string() }}) as fail_message,
    cast(csv_file_name as {{ dbt_utils.type_string() }}) as csv_file_name,
    cast(csv_file_size as {{ dbt_utils.type_bigint() }}) as csv_file_size,
    cast(field_mapping as {{ dbt_utils.type_string() }}) as field_mapping,
    cast(skip_triggers as {{ dbt_utils.type_bigint() }}) as skip_triggers,
    cast(overwrite_subs as {{ dbt_utils.type_bigint() }}) as overwrite_subs,
    cast(uploaded_by_id as {{ dbt_utils.type_bigint() }}) as uploaded_by_id,
    cast(delete_sms_subs as {{ dbt_utils.type_bigint() }}) as delete_sms_subs,
    cast(unsubscribe_sms as {{ dbt_utils.type_bigint() }}) as unsubscribe_sms,
    cast(csv_content_type as {{ dbt_utils.type_string() }}) as csv_content_type,
    cast(delete_new_users as {{ dbt_utils.type_bigint() }}) as delete_new_users,
    cast(new_mobile_count as {{ dbt_utils.type_bigint() }}) as new_mobile_count,
    cast(total_rows_count as {{ dbt_utils.type_bigint() }}) as total_rows_count,
    cast(add_sms_subscribed as {{ dbt_utils.type_bigint() }}) as add_sms_subscribed,
    cast(clear_blank_fields as {{ dbt_utils.type_bigint() }}) as clear_blank_fields,
    cast(overwrite_sms_subs as {{ dbt_utils.type_bigint() }}) as overwrite_sms_subs,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists_ab1') }}
-- lists
where 1 = 1
