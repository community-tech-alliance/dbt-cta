
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'demographic_interest_report') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   brandingInterest,
   engagementRate,
   newUsers,
   conversions,
   totalUsers,
   engagedSessions,
   totalRevenue,
   property_id,
   {{ dbt_utils.surrogate_key([
     '_airbyte_raw_id',
    '_airbyte_extracted_at',
    'date',
    'brandingInterest',
    'newUsers',
    'totalUsers',
    'engagedSessions',
    'property_id'
    ]) }} as _airbyte_demographic_interest_report_hashid
from {{ source('cta', 'demographic_interest_report') }}