{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('terms_ab1') }}
select
    cast(DueNextMonthDays as {{ dbt_utils.type_bigint() }}) as DueNextMonthDays,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(Name as {{ dbt_utils.type_string() }}) as Name,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    cast(Type as {{ dbt_utils.type_string() }}) as Type,
    {{ cast_to_boolean('Active') }} as Active,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(DueDays as {{ dbt_utils.type_bigint() }}) as DueDays,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(DiscountDayOfMonth as {{ dbt_utils.type_bigint() }}) as DiscountDayOfMonth,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(DiscountDays as {{ dbt_utils.type_bigint() }}) as DiscountDays,
    cast(DayOfMonthDue as {{ dbt_utils.type_bigint() }}) as DayOfMonthDue,
    cast(DiscountPercent as {{ dbt_utils.type_float() }}) as DiscountPercent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('terms_ab1') }}
-- terms
where 1 = 1

