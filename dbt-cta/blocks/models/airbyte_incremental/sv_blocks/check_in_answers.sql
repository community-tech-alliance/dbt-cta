{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('check_in_answers_scd') }}
select
    updated_at,
    user_id,
    created_at,
    id,
    text,
    question_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_check_in_answers_hashid
from {{ ref('check_in_answers_scd') }}
-- check_in_answers from {{ source('sv_blocks', '_airbyte_raw_check_in_answers') }}

