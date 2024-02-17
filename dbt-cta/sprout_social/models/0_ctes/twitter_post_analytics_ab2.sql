{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('twitter_post_analytics_ab1') }}

select
    *,
   {{ dbt_utils.surrogate_key([
    'sent',
    'text',
    'lifetime_comments_count',
    'lifetime_impressions',
    'lifetime_likes',
    'lifetime_reactions',
    'lifetime_shares_count',
    'lifetime_video_views',
    'perma_link',
    'created_time',
    'customer_profile_id'
    ]) }} as _airbyte_twitter_post_analytics_hashid
from {{ ref('twitter_post_analytics_ab1') }}
