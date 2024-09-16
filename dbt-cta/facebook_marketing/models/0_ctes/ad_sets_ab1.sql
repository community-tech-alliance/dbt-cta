{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'ad_sets') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    adlabels,
    bid_info,
    end_time,
    targeting,
    account_id,
    bid_amount,
    start_time,
    campaign_id,
    bid_strategy,
    created_time,
    daily_budget,
    updated_time,
    bid_constraints,
    lifetime_budget,
    promoted_object,
    budget_remaining,
    effective_status,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'end_time',
    'account_id',
    'start_time',
    'campaign_id',
    'bid_strategy',
    'created_time',
    'updated_time',
    'effective_status'
    ]) }} as _airbyte_ad_sets_hashid
from {{ source('cta', 'ad_sets') }}
