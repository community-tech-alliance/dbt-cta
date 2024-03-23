{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('questions_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(key as {{ dbt_utils.type_string() }}) as key,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(settings as {{ dbt_utils.type_string() }}) as settings,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(field_type as {{ dbt_utils.type_string() }}) as field_type,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(parent_group_id as {{ dbt_utils.type_bigint() }}) as parent_group_id,
    cast(question_hidden as {{ dbt_utils.type_bigint() }}) as question_hidden,
    cast(sent_to_children as {{ dbt_utils.type_bigint() }}) as sent_to_children,
    cast(originating_system as {{ dbt_utils.type_string() }}) as originating_system,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('questions_ab1') }}
-- questions
where 1 = 1
