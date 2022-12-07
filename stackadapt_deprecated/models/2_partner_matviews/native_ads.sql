-- depends_on: {{ source('cta', 'native_ads_base') }}
select
    _airbyte_native_ads_hashid,
    MAX(id) as id,
    MAX(icon) as icon,
    MAX(name) as name,
    MAX(state) as state,
    MAX(channel) as channel,
    MAX(cta_text) as cta_text,
    MAX(brandname) as brandname,
    MAX(click_url) as click_url,
    MAX(utm_source) as utm_source,
    MAX(utm_medium) as utm_medium,
    MAX(utm_campaign) as utm_campaign,
    MAX(utm_term) as utm_term,
    MAX(utm_content) as utm_content,
    MAX(ARRAY_TO_STRING(creatives,',')) as creatives,
    MAX(input_data) as input_data,
    MAX(audit_status) as audit_status,
    MAX(ARRAY_TO_STRING(vast_trackers,',')) as vast_trackers,
    MAX(ARRAY_TO_STRING(api_frameworks,',')) as api_frameworks,
    MAX(ARRAY_TO_STRING(imp_tracker_urls,',')) as imp_tracker_urls,
    MAX(_airbyte_ab_id) as _airbyte_ab_id,
    MAX(_airbyte_emitted_at) as _airbyte_emitted_at,
    MAX(_airbyte_normalized_at) as _airbyte_normalized_at
from {{ source('cta', 'native_ads_base') }}
where 1=1
group by _airbyte_native_ads_hashid