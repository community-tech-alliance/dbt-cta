{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('interaction_step_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(question as {{ dbt_utils.type_string() }}) as question,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    {{ cast_to_boolean('is_deleted') }} as is_deleted,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(answer_option as {{ dbt_utils.type_string() }}) as answer_option,
    cast(answer_actions as {{ dbt_utils.type_string() }}) as answer_actions,
    script_options,
    cast(parent_interaction_id as {{ dbt_utils.type_bigint() }}) as parent_interaction_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('interaction_step_ab1') }}
-- interaction_step
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

