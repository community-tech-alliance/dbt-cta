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
from {{ source('cta', 'visual_reviews_base') }}
