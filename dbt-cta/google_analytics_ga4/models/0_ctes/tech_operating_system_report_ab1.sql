
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'tech_operating_system_report') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   engagementRate,
   newUsers,
   conversions,
   totalUsers,
   engagedSessions,
   eventCount,
   totalRevenue,
   operatingSystem,
   property_id,
   {{ dbt_utils.surrogate_key([
     'date',
    'newUsers',
    'totalUsers',
    'engagedSessions',
    'eventCount',
    'operatingSystem',
    'property_id'
    ]) }} as _airbyte_tech_operating_system_report_hashid
from {{ source('cta', 'tech_operating_system_report') }}