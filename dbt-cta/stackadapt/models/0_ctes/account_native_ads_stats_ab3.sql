{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('account_native_ads_stats_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'ctr',
        'cvr',
        'imp',
        'ltr',
        'atos',
        'conv',
        'cost',
        'date',
        'ecpa',
        'ecpc',
        'ecpe',
        'ecpm',
        'ecpv',
        'rcpc',
        'rcpe',
        'rcpm',
        'roas',
        'click',
        'ecpcl',
        'rcpcl',
        'domain',
        'ios_id',
        boolean_to_string('is_ios'),
        'profit',
        's_conv',
        'channel',
        'conv_ip',
        'heading',
        'revenue',
        'tagline',
        'vcomp_0',
        'campaign',
        'end_date',
        'nativead',
        'vcomp_25',
        'vcomp_50',
        'vcomp_75',
        'vcomp_95',
        'click_url',
        '(SELECT STRING_AGG(TO_JSON_STRING(STRUCT(JSON_EXTRACT_SCALAR(element, \'$.url\') as url, JSON_EXTRACT_SCALAR(element, \'$.size\') as size)), \',\' ORDER BY JSON_EXTRACT_SCALAR(element, \'$.url\'), JSON_EXTRACT_SCALAR(element, \'$.size\')) FROM UNNEST(creatives) as element)',
        'line_item',
        'page_time',
        'uniq_conv',
        'atos_units',
        'conv_click',
        boolean_to_string('is_android'),
        'page_start',
        'start_date',
        'unique_imp',
        'vcomp_rate',
        'campaign_id',
        'engage_rate',
        'full_domain',
        'tp_cpc_cost',
        'tp_cpm_cost',
        'unique_conv',
        'line_item_id',
        'native_ad_id',
        'view_percent',
        'campaign_type',
        'page_time_15s',
        'native_ad_type',
        'sub_advertiser',
        'page_time_units',
        'conv_imp_derived',
        'conv_imp_time_avg',
        'sub_advertiser_id',
        'conv_click_time_avg',
        'unique_imp_inverse_rate',
    ]) }} as _airbyte_account_native_ads_stats_hashid,
    tmp.*
from {{ ref('account_native_ads_stats_ab2') }} as tmp
-- account_native_ads_stats
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

