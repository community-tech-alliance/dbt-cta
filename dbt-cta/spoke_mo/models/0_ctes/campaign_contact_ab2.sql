{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaign_contact_ab1') }}
select
    cast(zip as {{ dbt_utils.type_string() }}) as zip,
    cast(custom_fields as {{ dbt_utils.type_string() }}) as custom_fields,
    cast(timezone_offset as {{ dbt_utils.type_string() }}) as timezone_offset,
    {{ cast_to_boolean('is_opted_out') }} as is_opted_out,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(external_id as {{ dbt_utils.type_string() }}) as external_id,
    cast(cell as {{ dbt_utils.type_string() }}) as cell,
    cast(assignment_id as {{ dbt_utils.type_bigint() }}) as assignment_id,
    cast(message_status as {{ dbt_utils.type_string() }}) as message_status,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(error_code as {{ dbt_utils.type_bigint() }}) as error_code,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaign_contact_ab1') }}
-- campaign_contact
where 1 = 1


