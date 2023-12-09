{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_engagement_ab1') }}
select
    _airbyte_page_hashid,
    cast(social_sentence_without_like as {{ dbt_utils.type_string() }}) as social_sentence_without_like,
    cast(count_string as {{ dbt_utils.type_string() }}) as count_string,
    cast(social_sentence_with_like as {{ dbt_utils.type_string() }}) as social_sentence_with_like,
    cast(count_string_without_like as {{ dbt_utils.type_string() }}) as count_string_without_like,
    cast(count as {{ dbt_utils.type_bigint() }}) as count,
    cast(count_string_with_like as {{ dbt_utils.type_string() }}) as count_string_with_like,
    cast(social_sentence as {{ dbt_utils.type_string() }}) as social_sentence,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_engagement_ab1') }}
-- engagement at page/engagement
where 1 = 1

