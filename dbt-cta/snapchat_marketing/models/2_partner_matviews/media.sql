{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_media_hashid'
) }}

SELECT
   _airbyte_media_hashid
  ,MAX(id) as id
  ,MAX(name) as name
  ,MAX(type) as type
  ,MAX(file_name) as file_name
  ,MAX(created_at) as created_at
  ,MAX(updated_at) as updated_at
  ,MAX(visibility) as visibility
  ,MAX(media_status) as media_status
  ,MAX(ad_account_id) as ad_account_id
  ,MAX(download_link) as download_link
  ,MAX(is_demo_media) as is_demo_media
  ,MAX(image_metadata) as image_metadata
  ,MAX(video_metadata) as video_metadata
  ,MAX(file_size_in_bytes) as file_size_in_bytes
  ,MAX(duration_in_seconds) as duration_in_seconds
  ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
  ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'media_base') }}
GROUP BY _airbyte_media_hashid
