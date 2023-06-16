{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('lists_ab1') }}
select
    cast(list_folder_id as {{ dbt_utils.type_bigint() }}) as list_folder_id,
    cast(query as {{ dbt_utils.type_string() }}) as query,
    cast(search_params as {{ dbt_utils.type_string() }}) as search_params,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(repopulation_status as {{ dbt_utils.type_string() }}) as repopulation_status,
    cast(primary_emails_count as {{ dbt_utils.type_bigint() }}) as primary_emails_count,
    cast(people_count as {{ dbt_utils.type_bigint() }}) as people_count,
    {{ cast_to_boolean('queryable') }} as queryable,
    cast(phones_count as {{ dbt_utils.type_bigint() }}) as phones_count,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('refreshed_at') }} as {{ type_timestamp_without_timezone() }}) as refreshed_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(households_count as {{ dbt_utils.type_bigint() }}) as households_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('lists_ab1') }}
-- lists
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

