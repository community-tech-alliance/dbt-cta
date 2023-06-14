select
    answer_actions_data,
    user_id,
    created_at,
    answer_actions,
    id,
    text,
    title,
    campaign_id,
    _airbyte_canned_response_hashid
from {{ source('cta','canned_response_base') }}