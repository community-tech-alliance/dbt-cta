{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('classes_MetaData_ab1') }}
select
    _airbyte_classes_hashid,
    cast({{ empty_string_to_null('CreateTime') }} as {{ type_timestamp_with_timezone() }}) as CreateTime,
    cast({{ empty_string_to_null('LastUpdatedTime') }} as {{ type_timestamp_with_timezone() }}) as LastUpdatedTime,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('classes_MetaData_ab1') }}
-- MetaData at classes/MetaData
where 1 = 1

