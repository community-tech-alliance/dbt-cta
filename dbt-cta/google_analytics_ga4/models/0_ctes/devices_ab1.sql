{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'devices') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    newUsers,
    sessions,
    sessionsPerUser,
    totalUsers,
    averageSessionDuration,
    screenPageViewsPerSession,
    operatingSystem,
    bounceRate,
    property_id,
    deviceCategory,
    browser,
    screenPageViews,
    parse_date("%Y%m%d", date) as date,
   {{ dbt_utils.surrogate_key([
     'date',
    'newUsers',
    'sessions',
    'totalUsers',
    'operatingSystem',
    'property_id',
    'deviceCategory',
    'browser',
    'screenPageViews'
    ]) }} as _airbyte_devices_hashid
from {{ source('cta_raw', 'devices') }}
