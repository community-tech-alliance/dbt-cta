{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_Fax_ab1') }}
select
    _airbyte_customers_hashid,
    cast(FreeFormNumber as {{ dbt_utils.type_string() }}) as FreeFormNumber,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_Fax_ab1') }}
-- Fax at customers/Fax
where 1 = 1
