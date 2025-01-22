{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('vendors_PrimaryPhone_ab1') }}
select
    _airbyte_vendors_hashid,
    cast(FreeFormNumber as {{ dbt_utils.type_string() }}) as FreeFormNumber,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vendors_PrimaryPhone_ab1') }}
-- PrimaryPhone at vendors/PrimaryPhone
where 1 = 1
