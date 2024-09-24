{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tax_rates_ab1') }}
select
    cast(AgencyRef as {{ type_json() }}) as AgencyRef,
    cast(RateValue as {{ dbt_utils.type_float() }}) as RateValue,
    cast(Description as {{ dbt_utils.type_string() }}) as Description,
    cast(DisplayType as {{ dbt_utils.type_string() }}) as DisplayType,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(Name as {{ dbt_utils.type_string() }}) as Name,
    cast(SpecialTaxType as {{ dbt_utils.type_string() }}) as SpecialTaxType,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    EffectiveTaxRate,
    {{ cast_to_boolean('Active') }} as Active,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tax_rates_ab1') }}
-- tax_rates
where 1 = 1
