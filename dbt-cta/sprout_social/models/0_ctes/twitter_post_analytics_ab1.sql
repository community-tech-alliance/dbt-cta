{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'twitter_post_analytics') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    sent,
    text,
    metrics,
    -- metrics unnested
    {{ json_extract_scalar('metrics', ['lifetime.comments_count'], ['lifetime.comments_count']) }} as lifetime_comments_count,
    {{ json_extract_scalar('metrics', ['lifetime.impressions'], ['lifetime.impressions']) }} as lifetime_impressions,
    {{ json_extract_scalar('metrics', ['lifetime.likes'], ['lifetime.likes']) }} as lifetime_likes,
    {{ json_extract_scalar('metrics', ['lifetime.reactions'], ['lifetime.reactions']) }} as lifetime_reactions,
    {{ json_extract_scalar('metrics', ['lifetime.shares_count'], ['lifetime.shares_count']) }} as lifetime_shares_count,
    {{ json_extract_scalar('metrics', ['lifetime.video_views'], ['lifetime.video_views']) }} as lifetime_video_views,
    internal,
    -- internal unnested
    json_extract_array(internal, '$.tags') as internal_tags,
    perma_link,
    created_time,
    customer_profile_id
from {{ source('cta', 'twitter_post_analytics') }}
