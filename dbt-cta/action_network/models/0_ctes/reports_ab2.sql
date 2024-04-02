{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('reports_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(permalink as {{ dbt_utils.type_string() }}) as permalink,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(start_date as {{ dbt_utils.type_string() }}) as start_date,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(csv_file_name as {{ dbt_utils.type_string() }}) as csv_file_name,
    cast(csv_file_size as {{ dbt_utils.type_bigint() }}) as csv_file_size,
    cast(next_run_date as {{ dbt_utils.type_string() }}) as next_run_date,
    cast(report_format as {{ dbt_utils.type_string() }}) as report_format,
    cast(csv_updated_at as {{ dbt_utils.type_string() }}) as csv_updated_at,
    cast(first_permalink as {{ dbt_utils.type_string() }}) as first_permalink,
    cast(csv_content_type as {{ dbt_utils.type_string() }}) as csv_content_type,
    cast(recurring_emails as {{ dbt_utils.type_string() }}) as recurring_emails,
    cast(recurring_interval as {{ dbt_utils.type_string() }}) as recurring_interval,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('reports_ab1') }}
-- reports
where 1 = 1
