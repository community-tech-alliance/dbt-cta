-- depends_on: {{ source('cta', 'account_native_ads_stats_creatives_base') }}
select
    _airbyte_creatives_hashid,
    MAX(_airbyte_account_native_ads_stats_hashid) as _airbyte_account_native_ads_stats_hashid,
    MAX(url) as url,
    MAX(size) as size,
    MAX(_airbyte_ab_id) as _airbyte_ab_id,
    MAX(_airbyte_emitted_at) as _airbyte_emitted_at,
    MAX(_airbyte_normalized_at) as _airbyte_normalized_at
from {{ source('cta', 'account_native_ads_stats_creatives_base') }}
where 1 = 1
group by _airbyte_creatives_hashid

