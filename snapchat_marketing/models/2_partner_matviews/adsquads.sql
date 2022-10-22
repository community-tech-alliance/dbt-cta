{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_adsquads_hashid'
) }}

SELECT
   _airbyte_adsquads_hashid
  ,MAX(id) as id
  ,MAX(name) as name
  ,MAX(type) as type
  ,MAX(status) as status
  ,MAX(auto_bid) as auto_bid
  ,MAX(end_time) as end_time
  ,MAX(placement) as placement
  ,MAX(targeting) as targeting
  ,MAX(created_at) as created_at
  ,MAX(start_time) as start_time
  ,MAX(target_bid) as target_bid
  ,MAX(updated_at) as updated_at
  ,MAX(campaign_id) as campaign_id
  ,MAX(pacing_type) as pacing_type
  ,MAX(bid_strategy) as bid_strategy
  ,MAX(billing_event) as billing_event
  ,MAX(child_ad_type) as child_ad_type
  ,MAX(creation_state) as creation_state
  ,MAX(ARRAY_TO_STRING(delivery_status,',')) as delivery_status
  ,MAX(optimization_goal) as optimization_goal
  ,MAX(daily_budget_micro) as daily_budget_micro
  ,MAX(delivery_constraint) as delivery_constraint
  ,MAX(forced_view_setting) as forced_view_setting
  ,MAX(lifetime_budget_micro) as lifetime_budget_micro
  ,MAX(skadnetwork_properties) as skadnetwork_properties
  ,MAX(targeting_reach_status) as targeting_reach_status
  ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
  ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'adsquads_base') }}
GROUP BY _airbyte_adsquads_hashid
