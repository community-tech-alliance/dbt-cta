
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'traffic_sources') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   newUsers,
   sessions,
   sessionSource,
   sessionsPerUser,
   totalUsers,
   averageSessionDuration,
   screenPageViews,
   screenPageViewsPerSession,
   sessionMedium,
   bounceRate,
   property_id,
   {{ dbt_utils.surrogate_key([
     'date',
    'newUsers',
    'sessions',
    'sessionSource',
    'totalUsers',
    'screenPageViews',
    'sessionMedium',
    'property_id'
    ]) }} as _airbyte_traffic_sources_hashid
from {{ source('cta', 'traffic_sources') }}