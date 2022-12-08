{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ticket_fields_dependent_fields_ab1') }}
select
    _airbyte_ticket_fields_hashid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(label as {{ dbt_utils.type_string() }}) as label,
    cast(level as {{ dbt_utils.type_bigint() }}) as level,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(ticket_field_id as {{ dbt_utils.type_bigint() }}) as ticket_field_id,
    cast(label_for_customers as {{ dbt_utils.type_string() }}) as label_for_customers,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ticket_fields_dependent_fields_ab1') }}
-- dependent_fields at ticket_fields/dependent_fields
where 1 = 1

