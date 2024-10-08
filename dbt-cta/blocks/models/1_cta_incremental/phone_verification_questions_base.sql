{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('phone_verification_questions_ab3') }}
select
    question,
    updated_at,
    active,
    created_at,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_verification_questions_hashid
from {{ ref('phone_verification_questions_ab3') }}
-- phone_verification_questions from {{ source('cta', '_airbyte_raw_phone_verification_questions') }}
