{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ad_creatives_ab2') }}
select
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
        'effective_object_story_id',
        'effective_instagram_story_id',
    ]) }} as _airbyte_ad_creatives_hashid,
    tmp.*
from {{ ref('ad_creatives_ab2') }} tmp
-- ad_creatives
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

