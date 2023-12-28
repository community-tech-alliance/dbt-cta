{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'website_overview') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    PARSE_DATE("%Y%m%d", date) as date,
    newUsers,
    sessions,
    sessionsPerUser,
    totalUsers,
    averageSessionDuration,
    screenPageViews,
    screenPageViewsPerSession,
    bounceRate,
    property_id,
   {{ dbt_utils.surrogate_key([
     'date',
    'newUsers',
    'sessions',
    'totalUsers',
    'screenPageViews',
    'property_id'
    ]) }} as _airbyte_website_overview_hashid
from {{ source('cta', 'website_overview') }}
