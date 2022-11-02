{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('groups_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(group_type as {{ dbt_utils.type_string() }}) as group_type,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(escalate_to as {{ dbt_utils.type_bigint() }}) as escalate_to,
    cast(unassigned_for as {{ dbt_utils.type_string() }}) as unassigned_for,
    cast(business_hour_id as {{ dbt_utils.type_bigint() }}) as business_hour_id,
    cast(auto_ticket_assign as {{ dbt_utils.type_bigint() }}) as auto_ticket_assign,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('groups_ab1') }}
-- groups
where 1 = 1

