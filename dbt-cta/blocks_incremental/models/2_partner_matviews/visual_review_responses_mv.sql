select *
from {{ source('cta', 'visual_review_responses_base') }}
