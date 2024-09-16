{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('interaction_step_ab1') }}
select
    cast(answer_actions_data as {{ dbt_utils.type_string() }}) as answer_actions_data,
    {{ cast_to_boolean('is_deleted') }} as is_deleted,
    cast(question as {{ dbt_utils.type_string() }}) as question,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(answer_actions as {{ dbt_utils.type_string() }}) as answer_actions,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(answer_option as {{ dbt_utils.type_string() }}) as answer_option,
    cast(parent_interaction_id as {{ dbt_utils.type_bigint() }}) as parent_interaction_id,
    cast(script as {{ dbt_utils.type_string() }}) as script,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('interaction_step_ab1') }}
-- interaction_step
where 1 = 1
