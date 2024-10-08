{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'ad_creatives') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    body,
    name,
    title,
    status,
    actor_id,
    adlabels,
    link_url,
    url_tags,
    video_id,
    image_url,
    object_id,
    account_id,
    image_hash,
    link_og_id,
    object_url,
    image_crops,
    object_type,
    template_url,
    thumbnail_url,
    product_set_id,
    asset_feed_spec,
    object_story_id,
    applink_treatment,
    object_story_spec,
    template_url_spec,
    instagram_actor_id,
    instagram_story_id,
    thumbnail_data_url,
    call_to_action_type,
    instagram_permalink_url,
    effective_object_story_id,
    effective_instagram_story_id,
    regexp_extract(url_tags, r'utm_source=([^&]+)') as utm_source,
    regexp_extract(url_tags, r'utm_medium=([^&]+)') as utm_medium,
    regexp_extract(url_tags, r'utm_campaign=([^&]+)') as utm_campaign,
    regexp_extract(url_tags, r'utm_term=([^&]+)') as utm_term,
    regexp_extract(url_tags, r'utm_content=([^&]+)') as utm_content,
   {{ dbt_utils.surrogate_key([
     'id',
    'body',
    'name',
    'title',
    'status',
    'actor_id',
    'link_url',
    'url_tags',
    'video_id',
    'image_url',
    'object_id',
    'account_id',
    'image_hash',
    'link_og_id',
    'object_url',
    'object_type',
    'template_url',
    'thumbnail_url',
    'product_set_id',
    'object_story_id',
    'applink_treatment',
    'instagram_actor_id',
    'instagram_story_id',
    'thumbnail_data_url',
    'call_to_action_type',
    'instagram_permalink_url',
    'effective_object_story_id',
    'effective_instagram_story_id'
    ]) }} as _airbyte_ad_creatives_hashid
from {{ source('cta', 'ad_creatives') }}
