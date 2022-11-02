{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('discussion_forums_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(position as {{ dbt_utils.type_bigint() }}) as position,
    cast(forum_type as {{ dbt_utils.type_bigint() }}) as forum_type,
    company_ids,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(posts_count as {{ dbt_utils.type_bigint() }}) as posts_count,
    cast(topics_count as {{ dbt_utils.type_bigint() }}) as topics_count,
    cast(forum_visibility as {{ dbt_utils.type_bigint() }}) as forum_visibility,
    cast(forum_category_id as {{ dbt_utils.type_bigint() }}) as forum_category_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('discussion_forums_ab1') }}
-- discussion_forums
where 1 = 1

