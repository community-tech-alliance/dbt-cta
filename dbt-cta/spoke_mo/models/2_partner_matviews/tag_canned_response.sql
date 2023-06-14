select
    canned_response_id,
    tag_id,
    created_at,
    id,
    _airbyte_tag_canned_response_hashid
from {{ source('cta','tag_canned_response_base') }}