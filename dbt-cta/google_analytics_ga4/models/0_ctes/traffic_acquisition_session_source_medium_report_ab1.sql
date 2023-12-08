
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'traffic_acquisition_session_source_medium_report') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   sessions,
   conversions,
   totalUsers,
   eventsPerSession,
   eventCount,
   property_id,
   engagementRate,
   sessionSource,
   userEngagementDuration,
   engagedSessions,
   sessionMedium,
   totalRevenue,
   {{ dbt_utils.surrogate_key([
     '_airbyte_raw_id',
    '_airbyte_extracted_at',
    'date',
    'sessions',
    'totalUsers',
    'eventCount',
    'property_id',
    'sessionSource',
    'engagedSessions',
    'sessionMedium'
    ]) }} as _airbyte_traffic_acquisition_session_source_medium_report_hashid
from {{ source('cta', 'traffic_acquisition_session_source_medium_report') }}