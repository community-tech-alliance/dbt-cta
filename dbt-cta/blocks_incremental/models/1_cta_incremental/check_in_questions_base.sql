{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('check_in_questions_ab3') }}
select
    archived,
    check_in_id,
    turf_id,
    id,
    text,
    position,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_check_in_questions_hashid
from {{ ref('check_in_questions_ab3') }}
-- check_in_questions from {{ source('cta', '_airbyte_raw_check_in_questions') }}

