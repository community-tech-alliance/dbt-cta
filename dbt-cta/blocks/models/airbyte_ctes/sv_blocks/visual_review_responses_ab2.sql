{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('visual_review_responses_ab1') }}
select
    cast(shift_type as {{ dbt_utils.type_string() }}) as shift_type,
    {{ cast_to_boolean('implies_not_form') }} as implies_not_form,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(response as {{ dbt_utils.type_string() }}) as response,
    {{ cast_to_boolean('active') }} as active,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(grouping_metadata as {{ dbt_utils.type_string() }}) as grouping_metadata,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    {{ cast_to_boolean('implies_incomplete_form') }} as implies_incomplete_form,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('visual_review_responses_ab1') }}
-- visual_review_responses
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

