{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('taggings_ab1') }}
select
    cast(context as {{ dbt_utils.type_string() }}) as context,
    cast(tag_id as {{ dbt_utils.type_bigint() }}) as tag_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(tagger_type as {{ dbt_utils.type_string() }}) as tagger_type,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(phone_banking_question_id as {{ dbt_utils.type_bigint() }}) as phone_banking_question_id,
    cast(taggable_id as {{ dbt_utils.type_bigint() }}) as taggable_id,
    cast(tagger_id as {{ dbt_utils.type_bigint() }}) as tagger_id,
    cast(taggable_type as {{ dbt_utils.type_string() }}) as taggable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('taggings_ab1') }}
-- taggings
where 1 = 1
