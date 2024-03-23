{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('field_names_groups_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(field_name_id as {{ dbt_utils.type_bigint() }}) as field_name_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('field_names_groups_ab1') }}
-- field_names_groups
where 1 = 1
