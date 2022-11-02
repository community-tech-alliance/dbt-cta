{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('agents_contact_ab1') }}
select
    _airbyte_agents_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    {{ cast_to_boolean('active') }} as active,
    cast(mobile as {{ dbt_utils.type_string() }}) as mobile,
    cast(language as {{ dbt_utils.type_string() }}) as language,
    cast(job_title as {{ dbt_utils.type_string() }}) as job_title,
    cast(time_zone as {{ dbt_utils.type_string() }}) as time_zone,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(last_login_at as {{ dbt_utils.type_string() }}) as last_login_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('agents_contact_ab1') }}
-- contact at agents/contact
where 1 = 1

