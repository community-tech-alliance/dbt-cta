select
    vanId,
    isDeleted,
    answerText,
    ordering,
    promptId,
    id,
from {{ source('cta','ctas_prompts_answers_base') }}