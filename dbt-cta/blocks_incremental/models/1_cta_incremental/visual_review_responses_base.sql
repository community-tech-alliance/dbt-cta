{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('visual_review_responses_ab4') }}
select
    shift_type,
    implies_not_form,
    updated_at,
    response,
    active,
    created_at,
    description,
    grouping_metadata,
    id,
    implies_incomplete_form,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_visual_review_responses_hashid
from {{ ref('visual_review_responses_ab4') }}
-- visual_review_responses from {{ source('cta', '_airbyte_raw_visual_review_responses') }}
