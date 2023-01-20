{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('messaging_service_ab1') }}
select
    cast(name as {{ dbt_utils.type_string() }}) as name,
    {{ cast_to_boolean('active') }} as active,
    {{ cast_to_boolean('is_default') }} as is_default,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(service_type as {{ dbt_utils.type_string() }}) as service_type,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(encrypted_auth_token as {{ dbt_utils.type_string() }}) as encrypted_auth_token,
    cast(messaging_service_sid as {{ dbt_utils.type_string() }}) as messaging_service_sid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('messaging_service_ab1') }}
-- messaging_service
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

