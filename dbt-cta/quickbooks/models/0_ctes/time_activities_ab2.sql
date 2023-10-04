{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('time_activities_ab1') }}
select
    cast(EmployeeRef as {{ type_json() }}) as EmployeeRef,
    cast(NameOf as {{ dbt_utils.type_string() }}) as NameOf,
    cast(Description as {{ dbt_utils.type_string() }}) as Description,
    cast(Hours as {{ dbt_utils.type_bigint() }}) as Hours,
    cast({{ empty_string_to_null('TxnDate') }} as {{ type_date() }}) as TxnDate,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(Minutes as {{ dbt_utils.type_bigint() }}) as Minutes,
    cast(HourlyRate as {{ dbt_utils.type_bigint() }}) as HourlyRate,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(BillableStatus as {{ dbt_utils.type_string() }}) as BillableStatus,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(ItemRef as {{ type_json() }}) as ItemRef,
    cast(CustomerRef as {{ type_json() }}) as CustomerRef,
    {{ cast_to_boolean('Taxable') }} as Taxable,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('time_activities_ab1') }}
-- time_activities
where 1 = 1

