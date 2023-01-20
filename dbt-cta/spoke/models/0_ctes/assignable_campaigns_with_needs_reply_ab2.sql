{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('assignable_campaigns_with_needs_reply_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(autosend_status as {{ dbt_utils.type_string() }}) as autosend_status,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    {{ cast_to_boolean('limit_assignment_to_teams') }} as limit_assignment_to_teams,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('assignable_campaigns_with_needs_reply_ab1') }}
-- assignable_campaigns_with_needs_reply
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

