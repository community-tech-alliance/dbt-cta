{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('invoices_CustomField_ab1') }}
select
    _airbyte_invoices_hashid,
    cast(Type as {{ dbt_utils.type_string() }}) as Type,
    cast(DefinitionId as {{ dbt_utils.type_string() }}) as DefinitionId,
    cast(StringValue as {{ dbt_utils.type_string() }}) as StringValue,
    cast(Name as {{ dbt_utils.type_string() }}) as Name,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoices_CustomField_ab1') }}
-- CustomField at invoices/CustomField
where 1 = 1
