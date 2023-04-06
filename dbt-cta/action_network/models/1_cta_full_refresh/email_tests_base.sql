{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_tests_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_tests_hashid
from {{ ref('email_tests_ab3') }}
-- email_tests from {{ source('cta', '_airbyte_raw_email_tests') }}
where 1 = 1

