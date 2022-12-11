-- Final base SQL model
-- depends_on: {{ ref('users_emails_ab3') }}, {{ source('cta','users') }}
select
    _airbyte_users_hashid,
    type,
    address,
    primary,
    customType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    CURRENT_TIMESTAMP() as _airbyte_normalized_at,
    _airbyte_emails_hashid
from {{ ref('users_emails_ab3') }}
where 1 = 1
and cast(_airbyte_emitted_at as timestamp) >= cast('2022-12-02 10:00:40+00:00' as timestamp)

