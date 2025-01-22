{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('invoices_ShipAddr_ab1') }}
select
    _airbyte_invoices_hashid,
    cast(CountrySubDivisionCode as {{ dbt_utils.type_string() }}) as CountrySubDivisionCode,
    cast(Long as {{ dbt_utils.type_string() }}) as Long,
    cast(PostalCode as {{ dbt_utils.type_string() }}) as PostalCode,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(City as {{ dbt_utils.type_string() }}) as City,
    cast(Line1 as {{ dbt_utils.type_string() }}) as Line1,
    cast(Lat as {{ dbt_utils.type_string() }}) as Lat,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoices_ShipAddr_ab1') }}
-- ShipAddr at invoices/ShipAddr
where 1 = 1
