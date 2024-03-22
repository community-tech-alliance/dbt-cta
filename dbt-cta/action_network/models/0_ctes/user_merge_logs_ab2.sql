{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_merge_logs_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(list_id as {{ dbt_utils.type_bigint() }}) as list_id,
    cast(list_type as {{ dbt_utils.type_string() }}) as list_type,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(merged_user_id as {{ dbt_utils.type_bigint() }}) as merged_user_id,
    cast(removed_user_id as {{ dbt_utils.type_bigint() }}) as removed_user_id,
    cast(merged_user_email as {{ dbt_utils.type_string() }}) as merged_user_email,
    cast(removed_user_email as {{ dbt_utils.type_string() }}) as removed_user_email,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_merge_logs_ab1') }}
-- user_merge_logs
where 1 = 1
