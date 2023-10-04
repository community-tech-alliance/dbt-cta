{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_files_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('order') }},
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(file_type as {{ dbt_utils.type_bigint() }}) as file_type,
    cast(mime_type as {{ dbt_utils.type_string() }}) as mime_type,
    cast(parent_id as {{ dbt_utils.type_bigint() }}) as parent_id,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(download_number as {{ dbt_utils.type_bigint() }}) as download_number,
    cast(user_file_file_name as {{ dbt_utils.type_string() }}) as user_file_file_name,
    cast(user_file_file_size as {{ dbt_utils.type_bigint() }}) as user_file_file_size,
    cast(user_file_content_type as {{ dbt_utils.type_string() }}) as user_file_content_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_files_ab1') }}
-- user_files
where 1 = 1
