-- depends_on: {{ ref('conversion_trackers_base') }}
select
    _airbyte_conversion_trackers_hashid,
    MAX(id) as id,
    MAX(name) as name,
    MAX(user_id) as user_id,
    MAX(conv_type) as conv_type,
    MAX(post_time) as post_time,
    MAX(count_type) as count_type,
    MAX(description) as description,
    MAX(_airbyte_ab_id) as _airbyte_ab_id,
    MAX(_airbyte_emitted_at) as _airbyte_emitted_at,
    MAX(_airbyte_normalized_at) as _airbyte_normalized_at
from {{ ref('conversion_trackers_base') }}
where 1=1
group by _airbyte_conversion_trackers_hashid