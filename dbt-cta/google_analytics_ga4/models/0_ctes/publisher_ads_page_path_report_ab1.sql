
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'publisher_ads_page_path_report') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   publisherAdImpressions,
   adUnitExposure,
   totalAdRevenue,
   pagePath,
   property_id,
   publisherAdClicks,
   {{ dbt_utils.surrogate_key([
     '_airbyte_raw_id',
    '_airbyte_extracted_at',
    'date',
    'publisherAdImpressions',
    'pagePath',
    'property_id',
    'publisherAdClicks'
    ]) }} as _airbyte_publisher_ads_page_path_report_hashid
from {{ source('cta', 'publisher_ads_page_path_report') }}