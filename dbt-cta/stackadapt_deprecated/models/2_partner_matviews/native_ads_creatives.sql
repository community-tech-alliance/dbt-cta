-- depends_on: {{ source('cta', 'native_ads_creatives_base') }}
select
    _airbyte_creatives_hashid,
    MAX(_airbyte_native_ads_hashid) as _airbyte_native_ads_hashid,
    MAX(id) as id,
    MAX(url) as url,
    MAX(width) as width,
    MAX(height) as height,
    MAX(file_name) as file_name,
    MAX(_airbyte_ab_id) as _airbyte_ab_id,
    MAX(_airbyte_emitted_at) as _airbyte_emitted_at,
    MAX(_airbyte_normalized_at) as _airbyte_normalized_at
from {{ source('cta', 'native_ads_creatives_base') }}
where 1=1
group by _airbyte_creatives_hashid