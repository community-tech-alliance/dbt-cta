{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_wrappers_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(footer as {{ dbt_utils.type_string() }}) as footer,
    cast(header as {{ dbt_utils.type_string() }}) as header,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(syndicated as {{ dbt_utils.type_bigint() }}) as syndicated,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(logo_file_name as {{ dbt_utils.type_string() }}) as logo_file_name,
    cast(logo_file_size as {{ dbt_utils.type_bigint() }}) as logo_file_size,
    cast(logo_dimensions as {{ dbt_utils.type_string() }}) as logo_dimensions,
    cast(logo_content_type as {{ dbt_utils.type_string() }}) as logo_content_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_wrappers_ab1') }}
-- page_wrappers
where 1 = 1
