{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('relationships_ab1') }}
select
    cast(first_person_id as {{ dbt_utils.type_bigint() }}) as first_person_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(relationship_type_id as {{ dbt_utils.type_bigint() }}) as relationship_type_id,
    cast(second_person_id as {{ dbt_utils.type_bigint() }}) as second_person_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('relationships_ab1') }}
-- relationships
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

