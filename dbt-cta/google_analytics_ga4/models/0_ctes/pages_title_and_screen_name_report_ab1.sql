
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'pages_title_and_screen_name_report') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   newUsers,
   conversions,
   totalUsers,
   userEngagementDuration,
   screenPageViews,
   eventCount,
   totalRevenue,
   unifiedScreenName,
   property_id,
   {{ dbt_utils.surrogate_key([
     '_airbyte_raw_id',
    '_airbyte_extracted_at',
    'date',
    'newUsers',
    'totalUsers',
    'screenPageViews',
    'eventCount',
    'unifiedScreenName',
    'property_id'
    ]) }} as _airbyte_pages_title_and_screen_name_report_hashid
from {{ source('cta', 'pages_title_and_screen_name_report') }}