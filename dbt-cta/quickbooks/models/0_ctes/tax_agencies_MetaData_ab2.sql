{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tax_agencies_MetaData_ab1') }}
select
    _airbyte_tax_agencies_hashid,
    cast({{ empty_string_to_null('CreateTime') }} as {{ type_timestamp_with_timezone() }}) as CreateTime,
    cast({{ empty_string_to_null('LastUpdatedTime') }} as {{ type_timestamp_with_timezone() }}) as LastUpdatedTime,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tax_agencies_MetaData_ab1') }}
-- MetaData at tax_agencies/MetaData
where 1 = 1
