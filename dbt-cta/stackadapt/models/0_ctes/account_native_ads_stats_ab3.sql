{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('account_native_ads_stats_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'date',
        'channel',
        'campaign',
        '(SELECT STRING_AGG(TO_JSON_STRING(STRUCT(JSON_EXTRACT_SCALAR(element, \'$.url\') as url, JSON_EXTRACT_SCALAR(element, \'$.size\') as size)), \',\' ORDER BY JSON_EXTRACT_SCALAR(element, \'$.url\'), JSON_EXTRACT_SCALAR(element, \'$.size\')) FROM UNNEST(creatives) as element)',
        'end_date',
        'line_item',
        'start_date',
        'campaign_id',
        'line_item_id',
        'native_ad_id',
        'campaign_type',
        'native_ad_type',
        'sub_advertiser_id',
    ]) }} as _airbyte_account_native_ads_stats_hashid,
    tmp.*
from {{ ref('account_native_ads_stats_ab2') }} as tmp
-- account_native_ads_stats
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }} --noqa


