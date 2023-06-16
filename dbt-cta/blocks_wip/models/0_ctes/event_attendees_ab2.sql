{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('event_attendees_ab1') }}
select
    cast(needs as {{ dbt_utils.type_string() }}) as needs,
    cast({{ empty_string_to_null('marked_no_show_at') }} as {{ type_timestamp_without_timezone() }}) as marked_no_show_at,
    cast({{ empty_string_to_null('marked_walk_in_at') }} as {{ type_timestamp_without_timezone() }}) as marked_walk_in_at,
    cast(event_id as {{ dbt_utils.type_bigint() }}) as event_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(inviter_id as {{ dbt_utils.type_bigint() }}) as inviter_id,
    cast(creator_id as {{ dbt_utils.type_bigint() }}) as creator_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ empty_string_to_null('marked_attended_at') }} as {{ type_timestamp_without_timezone() }}) as marked_attended_at,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(person_id as {{ dbt_utils.type_bigint() }}) as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('event_attendees_ab1') }}
-- event_attendees
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

