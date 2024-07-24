{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('canned_response_ab1') }}
select
    cast(answer_actions_data as {{ dbt_utils.type_string() }}) as answer_actions_data,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(answer_actions as {{ dbt_utils.type_string() }}) as answer_actions,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(text as {{ dbt_utils.type_string() }}) as text,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('canned_response_ab1') }}
-- canned_response
where 1 = 1


