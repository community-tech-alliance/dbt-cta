{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('v2_voice_calls_export_ab1') }}
select
    cast(selected_voterbase_id as {{ dbt_utils.type_string() }}) as selected_voterbase_id,
    cast(user_last_name as {{ dbt_utils.type_string() }}) as user_last_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(source as {{ dbt_utils.type_string() }}) as source,
    cast(contact_id as {{ dbt_utils.type_bigint() }}) as contact_id,
    cast(duration as {{ dbt_utils.type_bigint() }}) as duration,
    cast(reference as {{ dbt_utils.type_string() }}) as reference,
    cast(van_id as {{ dbt_utils.type_string() }}) as van_id,
    cast(user_first_name as {{ dbt_utils.type_string() }}) as user_first_name,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(stopped_reason as {{ dbt_utils.type_string() }}) as stopped_reason,
    {{ cast_to_boolean('reported') }} as reported,
    cast(activity_id as {{ dbt_utils.type_bigint() }}) as activity_id,
    cast({{ empty_string_to_null('activity_published_at') }} as {{ type_timestamp_without_timezone() }}) as activity_published_at,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast({{ empty_string_to_null('stopped_at') }} as {{ type_timestamp_without_timezone() }}) as stopped_at,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(activity_title as {{ dbt_utils.type_string() }}) as activity_title,
    cast(user_email as {{ dbt_utils.type_string() }}) as user_email,
    cast(twilio_answered_by as {{ dbt_utils.type_string() }}) as twilio_answered_by,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('answered_at') }} as {{ type_timestamp_without_timezone() }}) as answered_at,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(pdi_id as {{ dbt_utils.type_string() }}) as pdi_id,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('v2_voice_calls_export_ab1') }}
-- v2_voice_calls_export
where 1 = 1

