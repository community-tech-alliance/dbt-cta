{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('teams_ab1') }}
select
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(organizer_id as {{ dbt_utils.type_bigint() }}) as organizer_id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(creator_id as {{ dbt_utils.type_bigint() }}) as creator_id,
    {{ cast_to_boolean('active') }} as active,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(leader_id as {{ dbt_utils.type_bigint() }}) as leader_id,
    cast(members_count as {{ dbt_utils.type_bigint() }}) as members_count,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teams_ab1') }}
-- teams
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

