{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_segments_hashid'
) }}

SELECT
   _airbyte_segments_hashid
  ,MAX(id) as id
  ,MAX(name) as name
  ,MAX(status) as status
  ,MAX(created_at) as created_at
  ,MAX(updated_at) as updated_at
  ,MAX(ARRAY_TO_STRING(visible_to,',')) as visible_to
  ,MAX(description) as description
  ,MAX(source_type) as source_type
  ,MAX(ad_account_id) as ad_account_id
  ,MAX(upload_status) as upload_status
  ,MAX(organization_id) as organization_id
  ,MAX(retention_in_days) as retention_in_days
  ,MAX(targetable_status) as targetable_status
  ,MAX(approximate_number_users) as approximate_number_users
  ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
  ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'segments_base') }}
GROUP BY _airbyte_segments_hashid

