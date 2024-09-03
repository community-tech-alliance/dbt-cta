{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ad_creatives_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(actor_id as {{ dbt_utils.type_string() }}) as actor_id,
    adlabels,
    cast(link_url as {{ dbt_utils.type_string() }}) as link_url,
    cast(url_tags as {{ dbt_utils.type_string() }}) as url_tags,
    cast(video_id as {{ dbt_utils.type_string() }}) as video_id,
    cast(image_url as {{ dbt_utils.type_string() }}) as image_url,
    cast(object_id as {{ dbt_utils.type_string() }}) as object_id,
    cast(account_id as {{ dbt_utils.type_string() }}) as account_id,
    cast(image_hash as {{ dbt_utils.type_string() }}) as image_hash,
    cast(link_og_id as {{ dbt_utils.type_string() }}) as link_og_id,
    cast(object_url as {{ dbt_utils.type_string() }}) as object_url,
    cast(image_crops as {{ type_json() }}) as image_crops,
    cast(object_type as {{ dbt_utils.type_string() }}) as object_type,
    cast(template_url as {{ dbt_utils.type_string() }}) as template_url,
    cast(thumbnail_url as {{ dbt_utils.type_string() }}) as thumbnail_url,
    cast(product_set_id as {{ dbt_utils.type_string() }}) as product_set_id,
    cast(asset_feed_spec as {{ type_json() }}) as asset_feed_spec,
    cast(object_story_id as {{ dbt_utils.type_string() }}) as object_story_id,
    cast(applink_treatment as {{ dbt_utils.type_string() }}) as applink_treatment,
    cast(object_story_spec as {{ type_json() }}) as object_story_spec,
    cast(template_url_spec as {{ type_json() }}) as template_url_spec,
    cast(instagram_actor_id as {{ dbt_utils.type_string() }}) as instagram_actor_id,
    cast(instagram_story_id as {{ dbt_utils.type_string() }}) as instagram_story_id,
    cast(thumbnail_data_url as {{ dbt_utils.type_string() }}) as thumbnail_data_url,
    cast(call_to_action_type as {{ dbt_utils.type_string() }}) as call_to_action_type,
    cast(instagram_permalink_url as {{ dbt_utils.type_string() }}) as instagram_permalink_url,
    cast(effective_object_story_id as {{ dbt_utils.type_string() }}) as effective_object_story_id,
    cast(effective_instagram_story_id as {{ dbt_utils.type_string() }}) as effective_instagram_story_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ad_creatives_ab1') }}
-- ad_creatives
where 1 = 1
