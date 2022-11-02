{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('agents_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(contact as {{ type_json() }}) as contact,
    {{ cast_to_boolean('available') }} as available,
    cast(signature as {{ dbt_utils.type_string() }}) as signature,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    {{ cast_to_boolean('occasional') }} as occasional,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(ticket_scope as {{ dbt_utils.type_bigint() }}) as ticket_scope,
    cast(last_active_at as {{ dbt_utils.type_string() }}) as last_active_at,
    cast(available_since as {{ dbt_utils.type_string() }}) as available_since,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('agents_ab1') }}
-- agents
where 1 = 1

