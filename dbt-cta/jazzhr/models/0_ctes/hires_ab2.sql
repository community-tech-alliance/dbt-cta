{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('hires_ab1') }}
select
    cast(hired_time as {{ dbt_utils.type_string() }}) as hired_time,
    cast(applicant_id as {{ dbt_utils.type_string() }}) as applicant_id,
    cast(job_id as {{ dbt_utils.type_string() }}) as job_id,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(workflow_step_id as {{ dbt_utils.type_string() }}) as workflow_step_id,
    cast(workflow_step_name as {{ dbt_utils.type_string() }}) as workflow_step_name,
    cast(hired_date as {{ dbt_utils.type_string() }}) as hired_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('hires_ab1') }}
-- hires
where 1 = 1

