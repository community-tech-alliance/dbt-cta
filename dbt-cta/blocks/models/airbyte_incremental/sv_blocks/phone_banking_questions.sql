{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('phone_banking_questions_scd') }}
select
    question_to_ask,
    updated_at,
    name,
    extras,
    created_at,
    id,
    type,
    created_by_user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_banking_questions_hashid
from {{ ref('phone_banking_questions_scd') }}
-- phone_banking_questions from {{ source('sv_blocks', '_airbyte_raw_phone_banking_questions') }}

