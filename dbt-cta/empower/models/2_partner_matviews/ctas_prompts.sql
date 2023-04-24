select
    ctaId,
    vanId,
    isDeleted,
    ordering,
    answers,
    answerInputType,
    id,
    promptText,
    dependsOnInitialDispositionResponse,
from {{ ref('ctas_prompts_base') }}