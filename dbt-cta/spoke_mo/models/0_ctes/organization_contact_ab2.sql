{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('organization_contact_ab1') }}
select
    cast(carrier as {{ dbt_utils.type_string() }}) as carrier,
    cast({{ empty_string_to_null('last_lookup') }} as {{ type_timestamp_with_timezone() }}) as last_lookup,
    cast(lookup_name as {{ dbt_utils.type_string() }}) as lookup_name,
    cast(status_code as {{ dbt_utils.type_bigint() }}) as status_code,
    cast(subscribe_status as {{ dbt_utils.type_bigint() }}) as subscribe_status,
    cast(service as {{ dbt_utils.type_string() }}) as service,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(contact_number as {{ dbt_utils.type_string() }}) as contact_number,
    cast(user_number as {{ dbt_utils.type_string() }}) as user_number,
    cast(last_error_code as {{ dbt_utils.type_bigint() }}) as last_error_code,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organization_contact_ab1') }}
-- organization_contact
where 1 = 1


