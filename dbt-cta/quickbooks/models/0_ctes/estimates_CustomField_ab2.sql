{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('estimates_CustomField_ab1') }}
select
    _airbyte_estimates_hashid,
    cast(Type as {{ dbt_utils.type_string() }}) as Type,
    cast(DefinitionId as {{ dbt_utils.type_string() }}) as DefinitionId,
    cast(Name as {{ dbt_utils.type_string() }}) as Name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('estimates_CustomField_ab1') }}
-- CustomField at estimates/CustomField
where 1 = 1

