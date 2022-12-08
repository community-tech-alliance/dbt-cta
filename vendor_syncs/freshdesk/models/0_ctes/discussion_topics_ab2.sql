{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('discussion_topics_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(hits as {{ dbt_utils.type_bigint() }}) as hits,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    {{ cast_to_boolean('locked') }} as locked,
    {{ cast_to_boolean('sticky') }} as sticky,
    cast(message as {{ dbt_utils.type_string() }}) as message,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(forum_id as {{ dbt_utils.type_bigint() }}) as forum_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(replied_by as {{ dbt_utils.type_bigint() }}) as replied_by,
    cast(stamp_type as {{ dbt_utils.type_bigint() }}) as stamp_type,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(user_votes as {{ dbt_utils.type_bigint() }}) as user_votes,
    cast(posts_count as {{ dbt_utils.type_bigint() }}) as posts_count,
    cast(merged_topic_id as {{ dbt_utils.type_bigint() }}) as merged_topic_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('discussion_topics_ab1') }}
-- discussion_topics
where 1 = 1

