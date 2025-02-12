{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('conversion_trackers_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(user_id as {{ dbt_utils.type_string() }}) as user_id,
    cast(conv_type as {{ dbt_utils.type_string() }}) as conv_type,
    cast(post_time as {{ dbt_utils.type_bigint() }}) as post_time,
    cast(count_type as {{ dbt_utils.type_string() }}) as count_type,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('conversion_trackers_ab1') }}
-- conversion_trackers
where 1 = 1
