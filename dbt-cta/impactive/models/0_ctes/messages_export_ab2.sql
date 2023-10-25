{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('messages_export_ab1') }}
select
    cast(sender_van_id as {{ dbt_utils.type_string() }}) as sender_van_id,
    cast(receiver_selected_voterbase_id as {{ dbt_utils.type_string() }}) as receiver_selected_voterbase_id,
    cast(receiver_id as {{ dbt_utils.type_bigint() }}) as receiver_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(sender_name as {{ dbt_utils.type_string() }}) as sender_name,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast(sender_selected_voterbase_id as {{ dbt_utils.type_string() }}) as sender_selected_voterbase_id,
    cast(sender_id as {{ dbt_utils.type_bigint() }}) as sender_id,
    cast(receiver_type as {{ dbt_utils.type_string() }}) as receiver_type,
    cast(aasm_message as {{ dbt_utils.type_string() }}) as aasm_message,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(activity_type as {{ dbt_utils.type_string() }}) as activity_type,
    cast(activity_id as {{ dbt_utils.type_bigint() }}) as activity_id,
    cast(receiver_name as {{ dbt_utils.type_string() }}) as receiver_name,
    cast({{ empty_string_to_null('activity_published_at') }} as {{ type_timestamp_without_timezone() }}) as activity_published_at,
    cast(activity_script_id as {{ dbt_utils.type_bigint() }}) as activity_script_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(aasm_state as {{ dbt_utils.type_string() }}) as aasm_state,
    cast(receiver_raw as {{ dbt_utils.type_string() }}) as receiver_raw,
    cast(twilio_segments as {{ dbt_utils.type_bigint() }}) as twilio_segments,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(activity_title as {{ dbt_utils.type_string() }}) as activity_title,
    cast(sender_raw as {{ dbt_utils.type_string() }}) as sender_raw,
    cast(sender_type as {{ dbt_utils.type_string() }}) as sender_type,
    cast(twilio_status as {{ dbt_utils.type_string() }}) as twilio_status,
    cast(message_type as {{ dbt_utils.type_string() }}) as message_type,
    cast(script_name as {{ dbt_utils.type_string() }}) as script_name,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast({{ empty_string_to_null('sent_at') }} as {{ type_timestamp_without_timezone() }}) as sent_at,
    cast({{ empty_string_to_null('received_at') }} as {{ type_timestamp_without_timezone() }}) as received_at,
    cast(error_code as {{ dbt_utils.type_string() }}) as error_code,
    cast(script_type as {{ dbt_utils.type_string() }}) as script_type,
    cast(receiver_van_id as {{ dbt_utils.type_string() }}) as receiver_van_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('messages_export_ab1') }}
-- messages_export
where 1 = 1

