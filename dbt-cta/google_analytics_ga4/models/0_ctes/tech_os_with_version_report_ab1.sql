
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'tech_os_with_version_report') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   engagementRate,
   newUsers,
   conversions,
   operatingSystemWithVersion,
   totalUsers,
   engagedSessions,
   eventCount,
   totalRevenue,
   property_id,
   {{ dbt_utils.surrogate_key([
     '_airbyte_raw_id',
    '_airbyte_extracted_at',
    'date',
    'newUsers',
    'operatingSystemWithVersion',
    'totalUsers',
    'engagedSessions',
    'eventCount',
    'property_id'
    ]) }} as _airbyte_tech_os_with_version_report_hashid
from {{ source('cta', 'tech_os_with_version_report') }}