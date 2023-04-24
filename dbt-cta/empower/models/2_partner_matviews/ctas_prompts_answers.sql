select
    vanId,
    isDeleted,
    answerText,
    ordering,
    promptId,
    id,
from {{ ref('ctas_prompts_answers_base') }}