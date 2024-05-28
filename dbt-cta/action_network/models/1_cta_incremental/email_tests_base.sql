{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('email_tests_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_email_tests_hashid
from {{ ref('email_tests_ab4') }}
