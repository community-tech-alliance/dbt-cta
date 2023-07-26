{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('applicants_ab1') }}
select
    cast(apply_date as {{ dbt_utils.type_string() }}) as apply_date,
    cast(job_id as {{ dbt_utils.type_string() }}) as job_id,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(job_title as {{ dbt_utils.type_string() }}) as job_title,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(prospect_phone as {{ dbt_utils.type_string() }}) as prospect_phone,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('applicants_ab1') }}
-- applicants
where 1 = 1

