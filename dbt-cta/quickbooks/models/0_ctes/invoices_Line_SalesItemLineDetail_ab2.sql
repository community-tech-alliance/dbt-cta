{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('invoices_Line_SalesItemLineDetail_ab1') }}
select
    _airbyte_Line_hashid,
    cast(UnitPrice as {{ dbt_utils.type_float() }}) as UnitPrice,
    cast({{ empty_string_to_null('ServiceDate') }} as {{ type_date() }}) as ServiceDate,
    cast(ClassRef as {{ type_json() }}) as ClassRef,
    cast(TaxCodeRef as {{ type_json() }}) as TaxCodeRef,
    cast(Qty as {{ dbt_utils.type_float() }}) as Qty,
    cast(ItemRef as {{ type_json() }}) as ItemRef,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoices_Line_SalesItemLineDetail_ab1') }}
-- SalesItemLineDetail at invoices/Line/SalesItemLineDetail
where 1 = 1
