{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_campaigns_hashid'
) }}

SELECT
   _airbyte_campaigns_hashid
  ,MAX(id) as id
  ,MAX(name) as name
  ,MAX(status) as status
  ,MAX(buy_model) as buy_model
  ,MAX(objective) as objective
  ,MAX(created_at) as created_at
  ,MAX(start_time) as start_time
  ,MAX(updated_at) as updated_at
  ,MAX(ad_account_id) as ad_account_id
  ,MAX(ARRAY_TO_STRING(delivery_status,',')) as delivery_status
  ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
  ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'campaigns_base') }}
GROUP BY _airbyte_campaigns_hashid
