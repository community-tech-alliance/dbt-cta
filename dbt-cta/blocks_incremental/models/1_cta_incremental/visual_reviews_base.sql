{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}

-- Final base SQL model
-- depends_on: {{ ref('visual_reviews_ab2') }}
select
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    user_id,
    created_at,
    updated_at,
    petition_page_id,
    petition_signature_id,
    visual_review_response_id,
    voter_registration_form_id,
    voter_registration_scan_id
from {{ ref('visual_reviews_ab2') }}
