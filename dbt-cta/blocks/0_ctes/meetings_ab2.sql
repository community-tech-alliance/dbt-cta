{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('meetings_ab1') }}
select
    cast({{ empty_string_to_null('start_time') }} as {{ type_timestamp_without_timezone() }}) as start_time,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    {{ cast_to_boolean('guest_attended') }} as guest_attended,
    cast({{ empty_string_to_null('end_time') }} as {{ type_timestamp_without_timezone() }}) as end_time,
    {{ cast_to_boolean('cancelled') }} as cancelled,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(location_id as {{ dbt_utils.type_bigint() }}) as location_id,
    cast(person_id as {{ dbt_utils.type_bigint() }}) as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('meetings_ab1') }}
-- meetings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

