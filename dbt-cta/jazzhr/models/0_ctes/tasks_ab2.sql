{{ config(
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tasks_ab1') }}
select
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(date_due as {{ dbt_utils.type_string() }}) as date_due,
    cast(owner_id as {{ dbt_utils.type_string() }}) as owner_id,
    cast(date_created as {{ dbt_utils.type_string() }}) as date_created,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(opener_name as {{ dbt_utils.type_string() }}) as opener_name,
    cast(object_id as {{ dbt_utils.type_string() }}) as object_id,
    cast(assignee_name as {{ dbt_utils.type_string() }}) as assignee_name,
    cast(due_whenever as {{ dbt_utils.type_string() }}) as due_whenever,
    cast(time_created as {{ dbt_utils.type_string() }}) as time_created,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(assignee_id as {{ dbt_utils.type_string() }}) as assignee_id,
    airbyte_raw_id,
    airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tasks_ab1') }}
-- tasks
where 1 = 1

