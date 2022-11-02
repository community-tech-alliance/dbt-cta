{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('discussion_comments_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    {{ cast_to_boolean('spam') }} as spam,
    {{ cast_to_boolean('trash') }} as trash,
    {{ cast_to_boolean('answer') }} as answer,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(forum_id as {{ dbt_utils.type_bigint() }}) as forum_id,
    cast(topic_id as {{ dbt_utils.type_bigint() }}) as topic_id,
    {{ cast_to_boolean('published') }} as published,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('discussion_comments_ab1') }}
-- discussion_comments
where 1 = 1

