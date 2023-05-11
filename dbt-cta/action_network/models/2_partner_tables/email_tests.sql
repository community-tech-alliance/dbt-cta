select
    _airbyte_emitted_at,
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
    winning_email_id
from {{ source('cta','email_tests_base') }}