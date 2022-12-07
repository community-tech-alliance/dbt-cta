-- depends_on: {{ source('cta', 'campaigns_day_part_base') }}
select
    _airbyte_day_part_hashid,
    MAX(_airbyte_campaigns_hashid) as _airbyte_campaigns_hashid,
    MAX(enabled) as enabled,
    MAX(end_hour) as end_hour,
    MAX(timezone) as timezone,
    MAX(start_hour) as start_hour,
    MAX(_airbyte_ab_id) as _airbyte_ab_id,
    MAX(_airbyte_emitted_at) as _airbyte_emitted_at,
    MAX(_airbyte_normalized_at) as _airbyte_normalized_at
from {{ source('cta', 'campaigns_day_part_base') }}
where 1=1
group by _airbyte_day_part_hashid
