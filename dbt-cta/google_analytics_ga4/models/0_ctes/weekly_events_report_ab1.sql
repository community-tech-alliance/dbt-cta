
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'weekly_events_report') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   totalUsers,
   eventCountPerUser,
   endDate,
   yearWeek,
   eventName,
   eventCount,
   totalRevenue,
   startDate,
   property_id,
   {{ dbt_utils.surrogate_key([
     'totalUsers',
    'endDate',
    'yearWeek',
    'eventName',
    'eventCount',
    'startDate',
    'property_id'
    ]) }} as _airbyte_weekly_events_report_hashid
from {{ source('cta', 'weekly_events_report') }}