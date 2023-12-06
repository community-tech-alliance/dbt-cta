{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_connected_instagram_account_ab1') }}
select
    _airbyte_page_hashid,
    cast(website as {{ dbt_utils.type_string() }}) as website,
    cast(shopping_review_status as {{ dbt_utils.type_string() }}) as shopping_review_status,
    cast(media_count as {{ dbt_utils.type_bigint() }}) as media_count,
    cast(followers_count as {{ dbt_utils.type_bigint() }}) as followers_count,
    cast(profile_picture_url as {{ dbt_utils.type_string() }}) as profile_picture_url,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(follows_count as {{ dbt_utils.type_bigint() }}) as follows_count,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(ig_id as {{ dbt_utils.type_bigint() }}) as ig_id,
    cast(biography as {{ dbt_utils.type_string() }}) as biography,
    cast(username as {{ dbt_utils.type_string() }}) as username,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_connected_instagram_account_ab1') }}
-- connected_instagram_account at page/connected_instagram_account
where 1 = 1

