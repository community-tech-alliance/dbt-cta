-- depends_on: {{ source('cta', 'native_ads_vast_trackers_base') }}
select
    _airbyte_vast_trackers_hashid,
    MAX(_airbyte_native_ads_hashid) as _airbyte_native_ads_hashid,
    MAX(url) as url,
    MAX(event_type) as event_type,
    MAX(_airbyte_ab_id) as _airbyte_ab_id,
    MAX(_airbyte_emitted_at) as _airbyte_emitted_at,
    MAX(_airbyte_normalized_at) as _airbyte_normalized_at
from {{ source('cta', 'native_ads_vast_trackers_base') }}
where 1=1
group by _airbyte_vast_trackers_hashid