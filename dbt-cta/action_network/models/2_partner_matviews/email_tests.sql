select
    id,
    hours,
    {{ adapter.quote('limit') }},
    params,
    auto_win,
    email_id,
    statistic,
    threshold,
    created_at,
    updated_at,
    winning_email_id,
    _airbyte_email_tests_hashid
from {{ ref('email_tests_base') }}