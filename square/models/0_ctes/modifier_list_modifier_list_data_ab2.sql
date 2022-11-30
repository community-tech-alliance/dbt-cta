{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('modifier_list_modifier_list_data_ab1') }}
select
    _airbyte_modifier_list_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    modifiers,
    cast(selection_type as {{ dbt_utils.type_string() }}) as selection_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('modifier_list_modifier_list_data_ab1') }}
-- modifier_list_data at modifier_list/modifier_list_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

