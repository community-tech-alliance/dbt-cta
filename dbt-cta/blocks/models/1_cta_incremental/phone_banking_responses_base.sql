{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('phone_banking_responses_ab3') }}
select
    answer_option_id,
    updated_at,
    created_at,
    id,
    question_id,
    call_id,
    open_ended_answer_text,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_banking_responses_hashid
from {{ ref('phone_banking_responses_ab3') }}
-- phone_banking_responses from {{ source('cta', '_airbyte_raw_phone_banking_responses') }}
