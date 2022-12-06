-- depends_on: {{ source('cta', 'advertisers_base') }}
select
    _airbyte_advertisers_hashid,
    MAX(id) as id,
    MAX(name) as name,
    MAX(description) as description,
    MAX(external_access) as external_access,
    MAX(ARRAY_TO_STRING(all_line_item_ids,',')) as all_line_item_ids,
    MAX(external_access_code) as external_access_code,
    MAX(_airbyte_ab_id) as _airbyte_ab_id,
    MAX(_airbyte_emitted_at) as _airbyte_emitted_at,
    MAX(_airbyte_normalized_at) as _airbyte_normalized_at
from {{ source('cta', 'advertisers_base') }}
where 1=1
group by _airbyte_advertisers_hashid
