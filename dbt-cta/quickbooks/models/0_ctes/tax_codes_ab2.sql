{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tax_codes_ab1') }}
select
    cast(Description as {{ dbt_utils.type_string() }}) as Description,
    cast(PurchaseTaxRateList as {{ type_json() }}) as PurchaseTaxRateList,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(SalesTaxRateList as {{ type_json() }}) as SalesTaxRateList,
    cast(Name as {{ dbt_utils.type_string() }}) as Name,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    {{ cast_to_boolean('Active') }} as Active,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(MetaData as {{ type_json() }}) as MetaData,
    {{ cast_to_boolean('TaxGroup') }} as TaxGroup,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    {{ cast_to_boolean('Hidden') }} as Hidden,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    {{ cast_to_boolean('Taxable') }} as Taxable,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tax_codes_ab1') }}
-- tax_codes
where 1 = 1
