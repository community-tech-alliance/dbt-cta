{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('voter_registration_scan_visual_review_responses_ab4') }}
select
    updated_at,
    voter_registration_scan_id,
    user_id,
    petition_signature_id,
    created_at,
    id,
    visual_review_response_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_voter_registration_scan_visual_review_responses_hashid
from {{ ref('voter_registration_scan_visual_review_responses_ab4') }}

