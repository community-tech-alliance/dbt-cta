{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('instagram_post_analytics_ab1') }}

select
    *,
   {{ dbt_utils.surrogate_key([
     'created_time',
    'perma_link',
    'text',
    'sent',
    'lifetime_impressions',
    'lifetime_impressions_unique',
    'lifetime_likes',
    'lifetime_reactions',
    'lifetime_shares_count',
    'lifetime_comments_count',
    'lifetime_saves',
    'lifetime_story_taps_back',
    'lifetime_story_taps_forward',
    'lifetime_story_exits',
    'lifetime_video_views'
    ]) }} as _airbyte_instagram_post_analytics_hashid
from {{ ref('instagram_post_analytics_ab1') }}