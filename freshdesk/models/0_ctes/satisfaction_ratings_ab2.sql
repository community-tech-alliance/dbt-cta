{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('satisfaction_ratings_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(ratings as {{ type_json() }}) as ratings,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(agent_id as {{ dbt_utils.type_bigint() }}) as agent_id,
    cast(feedback as {{ dbt_utils.type_string() }}) as feedback,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(survey_id as {{ dbt_utils.type_bigint() }}) as survey_id,
    cast(ticket_id as {{ dbt_utils.type_bigint() }}) as ticket_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('satisfaction_ratings_ab1') }}
-- satisfaction_ratings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

