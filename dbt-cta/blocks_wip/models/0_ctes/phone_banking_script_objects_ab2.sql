{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('phone_banking_script_objects_ab1') }}
select
    {{ cast_to_boolean('is_section_divider') }} as is_section_divider,
    cast(scriptable_id as {{ dbt_utils.type_bigint() }}) as scriptable_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(scriptable_type as {{ dbt_utils.type_string() }}) as scriptable_type,
    cast(script_id as {{ dbt_utils.type_bigint() }}) as script_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(question_id as {{ dbt_utils.type_bigint() }}) as question_id,
    cast(position_in_script as {{ dbt_utils.type_bigint() }}) as position_in_script,
    cast(script_text_id as {{ dbt_utils.type_bigint() }}) as script_text_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('phone_banking_script_objects_ab1') }}
-- phone_banking_script_objects
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

