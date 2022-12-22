{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ad_creatives_hashid'
) }}

-- depends_on: {{ source('cta', 'ad_creatives_base') }}

SELECT
     _airbyte_ad_creatives_hashid
    ,MAX(id) as id
    ,MAX(body) as body
    ,MAX(name) as name
    ,MAX(title) as title
    ,MAX(status) as status
    ,MAX(actor_id) as actor_id
    ,MAX(ARRAY_TO_STRING(adlabels,',')) as adlabels
    ,MAX(link_url) as link_url
    ,MAX(url_tags) as url_tags
    ,MAX(utm_source) as utm_source
    ,MAX(utm_medium) as utm_medium
    ,MAX(utm_campaign) as utm_campaign
    ,MAX(utm_term) as utm_term
    ,MAX(utm_content) as utm_content
    ,MAX(video_id) as video_id
    ,MAX(image_url) as image_url
    ,MAX(object_id) as object_id
    ,MAX(account_id) as account_id
    ,MAX(image_hash) as image_hash
    ,MAX(link_og_id) as link_og_id
    ,MAX(object_url) as object_url
    ,MAX(image_crops) as image_crops
    ,MAX(object_type) as object_type
    ,MAX(template_url) as template_url
    ,MAX(thumbnail_url) as thumbnail_url
    ,MAX(product_set_id) as product_set_id
    ,MAX(asset_feed_spec) as asset_feed_spec
    ,MAX(object_story_id) as object_story_id
    ,MAX(applink_treatment) as applink_treatment
    ,MAX(object_story_spec) as object_story_spec
    ,MAX(template_url_spec) as template_url_spec
    ,MAX(instagram_actor_id) as instagram_actor_id
    ,MAX(instagram_story_id) as instagram_story_id
    ,MAX(thumbnail_data_url) as thumbnail_data_url
    ,MAX(call_to_action_type) as call_to_action_type
    ,MAX(instagram_permalink_url) as instagram_permalink_url
    ,MAX(effective_object_story_id) as effective_object_story_id
    ,MAX(effective_instagram_story_id) as effective_instagram_story_id
    ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
FROM {{ source('cta', 'ad_creatives_base') }}
GROUP BY _airbyte_ad_creatives_hashid