{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('estimates_Line_SalesItemLineDetail_TaxCodeRef_ab1') }}
select
    _airbyte_SalesItemLineDetail_hashid,
    cast(value as {{ dbt_utils.type_string() }}) as value,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('estimates_Line_SalesItemLineDetail_TaxCodeRef_ab1') }}
-- TaxCodeRef at estimates/Line/SalesItemLineDetail/TaxCodeRef
where 1 = 1
