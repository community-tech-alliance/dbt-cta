{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('assignment_feedback_ab1') }}
select
    cast(feedback as {{ dbt_utils.type_string() }}) as feedback,
    cast(assignment_id as {{ dbt_utils.type_bigint() }}) as assignment_id,
    {{ cast_to_boolean('is_acknowledged') }} as is_acknowledged,
    cast(creator_id as {{ dbt_utils.type_bigint() }}) as creator_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    {{ cast_to_boolean('complete') }} as complete,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('assignment_feedback_ab1') }}
-- assignment_feedback
where 1 = 1
