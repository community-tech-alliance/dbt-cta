select *
from {{ source('cta', 'voter_registration_scan_visual_review_responses_base') }}
