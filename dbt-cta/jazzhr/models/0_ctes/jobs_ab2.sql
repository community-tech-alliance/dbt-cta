{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('jobs_ab1') }}
select
    cast(zip as {{ dbt_utils.type_string() }}) as zip,
    cast(maximum_salary as {{ dbt_utils.type_string() }}) as maximum_salary,
    cast(questionnaire as {{ dbt_utils.type_string() }}) as questionnaire,
    cast(send_to_job_boards as {{ dbt_utils.type_string() }}) as send_to_job_boards,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(original_open_date as {{ dbt_utils.type_string() }}) as original_open_date,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(board_code as {{ dbt_utils.type_string() }}) as board_code,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(minimum_salary as {{ dbt_utils.type_string() }}) as minimum_salary,
    cast(team_id as {{ dbt_utils.type_string() }}) as team_id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(hiring_lead as {{ dbt_utils.type_string() }}) as hiring_lead,
    cast(internal_code as {{ dbt_utils.type_string() }}) as internal_code,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(department as {{ dbt_utils.type_string() }}) as department,
    cast(country_id as {{ dbt_utils.type_string() }}) as country_id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('jobs_ab1') }}
-- jobs
where 1 = 1

