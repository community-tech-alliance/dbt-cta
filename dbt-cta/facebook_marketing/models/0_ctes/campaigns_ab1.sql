
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'campaigns') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   name,
   adlabels,
   objective,
   spend_cap,
   stop_time,
   account_id,
   start_time,
   buying_type,
   issues_info,
   bid_strategy,
   created_time,
   daily_budget,
   updated_time,
   lifetime_budget,
   budget_remaining,
   effective_status,
   source_campaign_id,
   special_ad_category,
   smart_promotion_type,
   budget_rebalance_flag,
   special_ad_category_country,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'objective',
    'stop_time',
    'account_id',
    'start_time',
    'buying_type',
    'bid_strategy',
    'created_time',
    'updated_time',
    'effective_status',
    'special_ad_category',
    'smart_promotion_type',
    'budget_rebalance_flag'
    ]) }} as _airbyte_campaigns_hashid
from {{ source('cta', 'campaigns') }}