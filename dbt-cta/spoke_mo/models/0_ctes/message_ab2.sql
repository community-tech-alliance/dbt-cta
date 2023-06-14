{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('message_ab1') }}
select
    {{ cast_to_boolean('is_from_contact') }} as is_from_contact,
    cast(campaign_contact_id as {{ dbt_utils.type_bigint() }}) as campaign_contact_id,
    cast({{ empty_string_to_null('queued_at') }} as {{ type_timestamp_with_timezone() }}) as queued_at,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(media as {{ dbt_utils.type_string() }}) as media,
    cast({{ empty_string_to_null('send_before') }} as {{ type_timestamp_with_timezone() }}) as send_before,
    cast(contact_number as {{ dbt_utils.type_string() }}) as contact_number,
    cast(user_number as {{ dbt_utils.type_string() }}) as user_number,
    cast({{ empty_string_to_null('sent_at') }} as {{ type_timestamp_with_timezone() }}) as sent_at,
    cast(assignment_id as {{ dbt_utils.type_bigint() }}) as assignment_id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(service as {{ dbt_utils.type_string() }}) as service,
    cast(service_id as {{ dbt_utils.type_string() }}) as service_id,
    cast(send_status as {{ dbt_utils.type_string() }}) as send_status,
    cast(messageservice_sid as {{ dbt_utils.type_string() }}) as messageservice_sid,
    cast(error_code as {{ dbt_utils.type_bigint() }}) as error_code,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(text as {{ dbt_utils.type_string() }}) as text,
    cast({{ empty_string_to_null('service_response_at') }} as {{ type_timestamp_with_timezone() }}) as service_response_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('message_ab1') }}
-- message
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

