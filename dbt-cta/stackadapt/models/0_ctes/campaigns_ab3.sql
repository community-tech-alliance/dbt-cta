{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'state',
        'budget',
        'channel',
        boolean_to_string('use_dma'),
        'bid_type',
        object_to_string('day_part'),
        'end_date',
        'timezone',
        'daily_cap',
        'created_at',
        'ip_options',
        'start_date',
        'updated_at',
        boolean_to_string('pace_evenly'),
        'city_options',
        'line_item_id',
        'advertiser_id',
        'campaign_type',
        'domain_action',
        'freq_cap_time',
        'optimize_type',
        array_to_string('all_native_ads_ids'),
        array_to_string('domain_options'),
        'freq_cap_limit',
        'optimize_value',
        array_to_string('country_options'),
        boolean_to_string('smart_targeting'),
        array_to_string('weekday_budgets'),
        boolean_to_string('weekday_enabled'),
        'bid_amount_total',
        array_to_string('category_options'),
        array_to_string('language_options'),
        array_to_string('us_state_options'),
        array_to_string('weekday_percents'),
        array_to_string('device_os_options'),
        array_to_string('uk_county_options'),
        array_to_string('conversion_tracker_ids'),
        array_to_string('device_type_options'),
        array_to_string('other_state_options'),
        array_to_string('supply_type_options'),
        array_to_string('custom_segments_list'),
        array_to_string('third_party_segments'),
        array_to_string('supply_source_options'),
        boolean_to_string('allow_iframe_engagement'),
        array_to_string('canada_province_options'),
        array_to_string('connection_type_options'),
        array_to_string('device_os_family_options'),
    ]) }} as _airbyte_campaigns_hashid,
    tmp.*
from {{ ref('campaigns_ab2') }} tmp
-- campaigns
where 1 = 1

