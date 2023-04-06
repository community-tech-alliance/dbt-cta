{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends_on: {{ ref('ad_creatives_ab2') }}
select
    id
    ,_airbyte_emitted_at
    ,_airbyte_ab_id
    ,body
    ,name
    ,title
    ,status
    ,actor_id
    ,adlabels
    ,link_url
    ,url_tags
    ,REGEXP_EXTRACT(url_tags,r'utm_source=([^&]+)') as utm_source
    ,REGEXP_EXTRACT(url_tags,r'utm_medium=([^&]+)') as utm_medium
    ,REGEXP_EXTRACT(url_tags,r'utm_campaign=([^&]+)') as utm_campaign
    ,REGEXP_EXTRACT(url_tags,r'utm_term=([^&]+)') as utm_term
    ,REGEXP_EXTRACT(url_tags,r'utm_content=([^&]+)') as utm_content
    ,video_id
    ,image_url
    ,object_id
    ,account_id
    ,image_hash
    ,link_og_id
    ,object_url
    ,image_crops
    ,object_type
    ,template_url
    ,thumbnail_url
    ,product_set_id
    ,asset_feed_spec
    ,object_story_id
    ,applink_treatment
    ,object_story_spec
    ,template_url_spec
    ,instagram_actor_id
    ,instagram_story_id
    ,thumbnail_data_url
    ,call_to_action_type
    ,instagram_permalink_url
    ,effective_object_story_id
    ,effective_instagram_story_id
from {{ ref('ad_creatives_ab2') }}
