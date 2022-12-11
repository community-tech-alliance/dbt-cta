-- Final base SQL model
-- depends_on: {{ ref('groups_ab3') }}, {{ source('cta','users') }}
select
    id,
    etag,
    kind,
    name,
    email,
    description,
    adminCreated,
    directMembersCount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_groups_hashid
from {{ ref('groups_ab3') }}
where 1 = 1
and cast(_airbyte_emitted_at as timestamp) >= cast('2022-12-02 10:00:40+00:00' as timestamp)
