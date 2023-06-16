{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('venues_ab1') }}
select
    cast(maximum_size as {{ dbt_utils.type_bigint() }}) as maximum_size,
    cast(rooms_available as {{ dbt_utils.type_bigint() }}) as rooms_available,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(address_id as {{ dbt_utils.type_bigint() }}) as address_id,
    {{ cast_to_boolean('it_support') }} as it_support,
    cast(largest_size as {{ dbt_utils.type_bigint() }}) as largest_size,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    {{ cast_to_boolean('public_transportation') }} as public_transportation,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(parking_spots as {{ dbt_utils.type_bigint() }}) as parking_spots,
    {{ cast_to_boolean('hosted_event') }} as hosted_event,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('venues_ab1') }}
-- venues
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

