{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sms_message_activities_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(link as {{ dbt_utils.type_string() }}) as link,
    cast(links as {{ dbt_utils.type_string() }}) as links,
    cast(link_id as {{ dbt_utils.type_bigint() }}) as link_id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(action_type as {{ dbt_utils.type_string() }}) as action_type,
    cast(recipient_id as {{ dbt_utils.type_bigint() }}) as recipient_id,
    cast(mobile_message_id as {{ dbt_utils.type_bigint() }}) as mobile_message_id,
    cast(twilio_message_id as {{ dbt_utils.type_string() }}) as twilio_message_id,
    cast(mobile_message_stat_id as {{ dbt_utils.type_bigint() }}) as mobile_message_stat_id,
    cast(mobile_message_field_id as {{ dbt_utils.type_bigint() }}) as mobile_message_field_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sms_message_activities_ab1') }}
-- sms_message_activities
where 1 = 1
