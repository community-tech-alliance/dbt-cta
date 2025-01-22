{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tax_agencies_ab1') }}
select
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    {{ cast_to_boolean('TaxTrackedOnPurchases') }} as TaxTrackedOnPurchases,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(TaxRegistrationNumber as {{ dbt_utils.type_string() }}) as TaxRegistrationNumber,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(DisplayName as {{ dbt_utils.type_string() }}) as DisplayName,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    {{ cast_to_boolean('TaxTrackedOnSales') }} as TaxTrackedOnSales,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tax_agencies_ab1') }}
-- tax_agencies
where 1 = 1
