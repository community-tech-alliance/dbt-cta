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
from {{ source('cta','ctas_prompts_base') }}