-- Final base SQL model
-- depends_on: {{ source('cta', 'users_externalids_ab3') }}
select
    _airbyte_users_hashid,
    type,
    value,
    customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_externalIds_hashid
from {{ source('cta', 'users_externalids_ab3') }}
where 1 = 1
and cast(_airbyte_emitted_at as timestamp) >= cast('2022-12-02 10:00:40+00:00' as timestamp)
