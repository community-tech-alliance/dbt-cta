{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('assignable_needs_message_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(message_status as {{ dbt_utils.type_string() }}) as message_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('assignable_needs_message_ab1') }}
-- assignable_needs_message
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

