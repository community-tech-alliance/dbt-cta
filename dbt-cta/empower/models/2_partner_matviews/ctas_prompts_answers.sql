select
    _airbyte_extracted_at,
    _airbyte_prompts_hashid,
    vanId,
    isDeleted,
    answerText,
    ordering,
    promptId,
    id,
    _airbyte_answers_hashid
from {{ source('cta','ctas_prompts_answers_base') }}
