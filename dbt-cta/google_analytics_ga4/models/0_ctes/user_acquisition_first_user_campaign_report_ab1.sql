
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'user_acquisition_first_user_campaign_report') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   engagementRate,
   newUsers,
   conversions,
   totalUsers,
   userEngagementDuration,
   engagedSessions,
   firstUserCampaignName,
   eventCount,
   totalRevenue,
   property_id,
   {{ dbt_utils.surrogate_key([
     'date',
    'newUsers',
    'totalUsers',
    'engagedSessions',
    'firstUserCampaignName',
    'eventCount',
    'property_id'
    ]) }} as _airbyte_user_acquisition_first_user_campaign_report_hashid
from {{ source('cta', 'user_acquisition_first_user_campaign_report') }}