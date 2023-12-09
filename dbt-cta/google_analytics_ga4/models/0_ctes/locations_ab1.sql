
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'locations') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   country,
   newUsers,
   sessions,
   sessionsPerUser,
   totalUsers,
   city,
   averageSessionDuration,
   screenPageViewsPerSession,
   bounceRate,
   property_id,
   screenPageViews,
   region,
   {{ dbt_utils.surrogate_key([
     'date',
    'country',
    'newUsers',
    'sessions',
    'totalUsers',
    'city',
    'property_id',
    'screenPageViews',
    'region'
    ]) }} as _airbyte_locations_hashid
from {{ source('cta', 'locations') }}