-- depends_on: {{ source('cta', 'native_ads_input_data_base') }}
select
    _airbyte_input_data_hashid,
    MAX(_airbyte_native_ads_hashid) as _airbyte_native_ads_hashid,
    MAX(width) as width,
    MAX(height) as height,
    MAX(heading) as heading,
    MAX(img_url) as img_url,
    MAX(js_code) as js_code,
    MAX(tagline) as tagline,
    MAX(is_expandable) as is_expandable,
    MAX(_airbyte_ab_id) as _airbyte_ab_id,
    MAX(_airbyte_emitted_at) as _airbyte_emitted_at,
    MAX(_airbyte_normalized_at) as _airbyte_normalized_at
from {{ source('cta', 'native_ads_input_data_base') }}
where 1=1
group by _airbyte_input_data_hashid