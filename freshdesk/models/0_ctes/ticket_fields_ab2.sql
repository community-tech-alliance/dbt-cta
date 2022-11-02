{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ticket_fields_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(label as {{ dbt_utils.type_string() }}) as label,
    {{ cast_to_boolean('is_fsm') }} as is_fsm,
    choices,
    {{ cast_to_boolean(adapter.quote('default')) }} as {{ adapter.quote('default') }},
    cast(position as {{ dbt_utils.type_bigint() }}) as position,
    {{ cast_to_boolean('portal_cc') }} as portal_cc,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(portal_cc_to as {{ dbt_utils.type_string() }}) as portal_cc_to,
    dependent_fields,
    {{ cast_to_boolean('customers_can_edit') }} as customers_can_edit,
    cast(label_for_customers as {{ dbt_utils.type_string() }}) as label_for_customers,
    {{ cast_to_boolean('required_for_agents') }} as required_for_agents,
    {{ cast_to_boolean('required_for_closure') }} as required_for_closure,
    {{ cast_to_boolean('displayed_to_customers') }} as displayed_to_customers,
    {{ cast_to_boolean('required_for_customers') }} as required_for_customers,
    {{ cast_to_boolean('field_update_in_progress') }} as field_update_in_progress,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ticket_fields_ab1') }}
-- ticket_fields
where 1 = 1

