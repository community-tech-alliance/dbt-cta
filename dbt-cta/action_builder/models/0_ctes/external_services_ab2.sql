{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('external_services_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(client_id as {{ dbt_utils.type_string() }}) as client_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(expires_in as {{ dbt_utils.type_bigint() }}) as expires_in,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(workflow_id as {{ dbt_utils.type_string() }}) as workflow_id,
    cast(access_token as {{ dbt_utils.type_string() }}) as access_token,
    cast(service_name as {{ dbt_utils.type_string() }}) as service_name,
    cast(client_secret as {{ dbt_utils.type_string() }}) as client_secret,
    cast({{ empty_string_to_null('token_updated_at') }} as {{ type_timestamp_without_timezone() }}) as token_updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('external_services_ab1') }}
-- external_services
where 1 = 1
