select
    feedback,
    assignment_id,
    is_acknowledged,
    creator_id,
    created_at,
    id,
    complete,
    _airbyte_extracted_at,
    _airbyte_assignment_feedback_hashid
from {{ source('cta','assignment_feedback_base') }}